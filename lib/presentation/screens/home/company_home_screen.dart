import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:cargo_linker/presentation/widgets/button_circular_progress_indicator.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  static const String routeName = "companyHome";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("COMPANY HOME"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to CargoLinker!",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const Spacing(multiply: 4),
                PrimaryButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const ButtonCircularProgressIndicator();
                      }
                      return const Text('Logout');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
