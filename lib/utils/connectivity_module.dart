import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:synchronized/synchronized.dart';

class InternetConnectivityModule {
  final InternetConnectionChecker customInstance =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );

  InternetConnectivityModule._();

  static final _instance = InternetConnectivityModule._();

  static InternetConnectivityModule get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;
  static bool isOnline = true;

  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
      countForCheck = 0;
    });
  }

  int countForCheck = 0;

  Future<bool> checkInternetStatus() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return _checkStatus(result);
  }

  Future<bool> _checkStatus(List<ConnectivityResult> result) async {
    bool isOnline = false;
    if (result.contains(ConnectivityResult.none) == false) {
      try {
        await Future.delayed(const Duration(seconds: 1), () {});
        final resultLookup = await customInstance.hasConnection;

        if (resultLookup) {
          isOnline = true;
        } else {
          isOnline = false;
        }
        Future.delayed(const Duration(seconds: 1), () {
          if (countForCheck++ <= 3) {
            _checkStatus(result);
          }
        });
      } on SocketException catch (_) {
        isOnline = false;
        Future.delayed(const Duration(seconds: 1), () {
          if (countForCheck++ <= 5) {
            _checkStatus(result);
          }
        });
      } catch (e) {
        isOnline = false;
        Future.delayed(const Duration(seconds: 1), () {
          if (countForCheck++ <= 5) {
            _checkStatus(result);
          }
        });
      }
    }

    InternetConnectivityModule.isOnline = isOnline;
    _controller.sink.add(isOnline);
    return isOnline;
  }

  void disposeStream() => _controller.close();
}

class InternetStatusController extends ChangeNotifier {
  InternetStatusController._();

  static final _instance = InternetStatusController._();

  static InternetStatusController get instance => _instance;
  bool isOnline = InternetConnectivityModule.isOnline;

  var lock = Lock();

  void changeInternetStatus(bool status) async {
    await lock.synchronized(() {
      if (isOnline != status) {
        isOnline = status;
        notifyListeners();
      }
    });
  }
}
