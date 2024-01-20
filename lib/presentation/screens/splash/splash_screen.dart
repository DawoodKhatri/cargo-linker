import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/screens/auth/login_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_submit_verification_screen.dart';
import 'package:cargo_linker/presentation/screens/home/home_screen.dart';
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
          Navigator.pushReplacementNamed(context, CompanySubmitVerificationScreen.routeName);
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
    );
  }
}
