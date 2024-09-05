import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:odc_mobile_project/m_user/ui/pages/onboarding/OnboardingCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ctrl = ref.read(onboardingCtrlProvider.notifier);
      await ctrl.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
      splashIconSize: 200,
      splash: Center(
        child: Lottie.asset(
          "assets/animations/car-looping.json",
        ),
      ),
      // nextScreen: OnboardingPage(),
      // nextRoute: context.pushNamed(Urls.onboarding.name).toString() ,
      screenRouteFunction: () async => await context.pushNamed(Urls.onboarding.name).toString()   ,
      duration: 3500,
      backgroundColor: Colors.white,
    );
  }
}
