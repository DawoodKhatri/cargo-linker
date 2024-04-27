import 'package:cargo_linker/presentation/screens/auth/login_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/signup_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/verification_screen.dart';
import 'package:cargo_linker/presentation/screens/trader_booking/trader_booking_screen.dart';
import 'package:cargo_linker/presentation/screens/company_list_container/company_list_container.dart';
import 'package:cargo_linker/presentation/screens/home/company/company_home_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_status_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_submit_screen.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:cargo_linker/presentation/screens/home/trader/trader_home_screen.dart';
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

      case CompanyVerificationSubmitScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => CompanyVerificationSubmitScreen());

      case CompanyVerificationStatusScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const CompanyVerificationStatusScreen());

      case CompanyHomeScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const CompanyHomeScreen());

      case CompanyListContainerScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => CompanyListContainerScreen());

      case TraderHomeScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const TraderHomeScreen());

      case TraderBookingScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const TraderBookingScreen());

      default:
        return null;
    }
  }
}
