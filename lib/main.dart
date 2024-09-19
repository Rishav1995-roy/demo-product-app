import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_app/locator.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/utils/local_storage.dart';
import 'app.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await LocalStorage.initialiseLocalStorage();
      await initializeDependencies();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.colorffffff, // this one for android
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // this one for iOS
        ),
      );
      ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
        FlutterError.presentError(errorDetails);
        return const IgnorePointer();
      };
      runApp(const ProductApp());
    },
    (error, stack) {
      try {
        debugPrint(
          error.toString() + stack.toString(),
        );
      } catch (e) {
        debugPrint(
          e.toString(),
        );
      }
    },
  );
}
