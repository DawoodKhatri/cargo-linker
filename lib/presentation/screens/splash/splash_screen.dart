import 'package:cargo_linker/data/constants/user_roles.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:cargo_linker/presentation/screens/auth/login_screen.dart';
import 'package:cargo_linker/presentation/screens/home/company/company_home_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_status_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_submit_screen.dart';
import 'package:cargo_linker/presentation/screens/home/trader/trader_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).authCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState || state is AuthLoggedOutState) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else if (state is AuthLoggedInState) {
          if (BlocProvider.of<AuthCubit>(context).type == USER_ROLES.company) {
            BlocProvider.of<CompanyVerificationCubit>(context)
                .checkVerification();
          }
          if (BlocProvider.of<AuthCubit>(context).type == USER_ROLES.trader) {
            Navigator.pushReplacementNamed(context, TraderHomeScreen.routeName);
          }
        }
      },
      child: BlocListener<CompanyVerificationCubit, CompanyVerificationState>(
        listener: (context, state) {
          if (state is CompanyVerificationPendingState) {
            Navigator.pushReplacementNamed(
                context, CompanyVerificationSubmitScreen.routeName);
          } else if (state is CompanyVerificationOngoingState) {
            Navigator.pushReplacementNamed(
                context, CompanyVerificationStatusScreen.routeName);
          } else if (state is CompanyVerificationCompleteState) {
            Navigator.pushReplacementNamed(context, CompanyHomeScreen.routeName);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Image.asset(
                "assets/CargoLinkerTransparent.png",
                width: 250,
                height: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
