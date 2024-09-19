import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/screens/product_list_screen/screen/product_list_screen.dart';
import 'package:product_app/screens/splash_screen/widget/splash_widget.dart';
import 'package:product_app/utils/context_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/spalsh-screen';

  static GoRoute route() {
    return GoRoute(
      name: 'splash',
      path: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.afterWidgetBuilt(() {
      context.delayInMilliseconds(time: 2000, afterDelay: goScreen);
    });
  }

  void goScreen() {
    context.go(ProductListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const SplashWidget();
  }
}
