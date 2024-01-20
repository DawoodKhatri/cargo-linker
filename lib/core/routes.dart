import 'package:cargo_linker/presentation/screens/auth/login_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/signup_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/verification_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_submit_verification_screen.dart';
import 'package:cargo_linker/presentation/screens/home/home_screen.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case SignupScreen.routeName:
        return MaterialPageRoute(builder: (context) => SignupScreen());

      case VerificationScreen.routeName:
        return MaterialPageRoute(builder: (context) => VerificationScreen());

      case CompanySubmitVerificationScreen.routeName:
        return MaterialPageRoute(
            builder: (context) =>  CompanySubmitVerificationScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return null;
    }
  }
}
