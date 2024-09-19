import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:product_app/locator.dart';
import 'package:product_app/network/repository/product_repository.dart';
import 'package:product_app/screens/product_details_screen/screen/product_deatils_screen.dart';
import 'package:product_app/screens/product_list_screen/screen/product_list_screen.dart';
import 'package:product_app/screens/splash_screen/screen/splash_screen.dart';
import 'package:product_app/utils/context_extensions.dart';
import 'package:product_app/resource/colors.dart';
import 'package:product_app/utils/connectivity_module.dart';
import 'package:product_app/utils/dismiss_keyboard_module.dart';
import 'package:product_app/resource/strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldState>();

/// The route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: SplashScreen.routeName,
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    SplashScreen.route(),
    ProductDetailsScreen.route(),
    ProductListScreen.route(productRepository: locator<ProductRepository>()),
  ],
);

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  @override
  void initState() {
    super.initState();
    context.afterWidgetBuilt(() {
      locator<InternetConnectivityModule>().initialise();
      locator<InternetConnectivityModule>().myStream.listen((source) {
        locator<InternetStatusController>().changeInternetStatus(source);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarBrightness: Brightness.dark,
      ),
    );
    return ResponsiveSizer(
      builder: (_, orientation, screenType) {
        return DismissKeyboard(
          child: GlobalLoaderOverlay(
            duration: Durations.medium4,
            reverseDuration: Durations.medium4,
            overlayColor: AppColors.color989898.withOpacity(0.5),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return Center(
                child: SpinKitWaveSpinner(
                  color: AppColors.color8784D3,
                  trackColor: AppColors.color8784D3,
                  waveColor: AppColors.color8784D3,
                  curve: Curves.decelerate,
                  size: 80.0,
                ),
              );
            },
            child: MaterialApp.router(
              title: Strings.appName,
              debugShowCheckedModeBanner: kDebugMode,
              routerConfig: appRouter,
            ),
          ),
        );
      },
    );
  }
}
