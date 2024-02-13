import 'package:cargo_linker/data/constants/user_roles.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:cargo_linker/presentation/screens/auth/signup_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/verification_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_status_screen.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_submit_screen.dart';
import 'package:cargo_linker/presentation/screens/home/company_home_screen.dart';
import 'package:cargo_linker/presentation/screens/home/trader_home_screen.dart';
import 'package:cargo_linker/presentation/widgets/button_circular_progress_indicator.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static const String routeName = "login";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOTPVerificationState) {
          if (!state.isResend) {
            Navigator.pushNamed(context, VerificationScreen.routeName);
          }
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is AuthLoggedInState) {
          if (BlocProvider.of<AuthCubit>(context).type == USER_ROLES.company) {
            BlocProvider.of<CompanyVerificationCubit>(context)
                .checkVerification();
          }
          if (BlocProvider.of<AuthCubit>(context).type == USER_ROLES.trader) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, TraderHomeScreen.routeName);
          }
        }
      },
      child: BlocListener<CompanyVerificationCubit, CompanyVerificationState>(
        listener: (context, state) {
          if (state is CompanyVerificationPendingState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(
                context, CompanyVerificationSubmitScreen.routeName);
          } else if (state is CompanyVerificationOngoingState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(
                context, CompanyVerificationStatusScreen.routeName);
          } else if (state is CompanyVerificationCompleteState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(
                context, CompanyHomeScreen.routeName);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("LOGIN"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    const Text(
                      "Fill these details to login to your account",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    const Spacing(multiply: 6),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                              width:
                                  MediaQuery.of(context).size.width / 2 - 18),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).cardTheme.color,
                          color: Theme.of(context).primaryColor,
                          isSelected: [
                            BlocProvider.of<AuthCubit>(context).type ==
                                USER_ROLES.company,
                            BlocProvider.of<AuthCubit>(context).type ==
                                USER_ROLES.trader,
                          ],
                          children: const [
                            Text("Company Login"),
                            Text("Trader Login"),
                          ],
                          onPressed: (index) {
                            BlocProvider.of<AuthCubit>(context).switchType(
                                index == 0
                                    ? USER_ROLES.company
                                    : USER_ROLES.trader);
                          },
                        );
                      },
                    ),
                    const Spacing(multiply: 6),
                    PrimaryTextField(
                      controller: emailController,
                      labelText: 'Email',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter an email';
                        } else if (!EmailValidator.validate(value.trim())) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                    ),
                    const Spacing(multiply: 3),
                    PrimaryTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const Spacing(multiply: 4),
                    PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(
                              emailController.text.trim(),
                              passwordController.text.trim());
                        }
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return const ButtonCircularProgressIndicator();
                          }
                          return const Text('Login');
                        },
                      ),
                    ),
                    const Spacing(multiply: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ?"),
                        const Spacing(),
                        PrimaryTextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignupScreen.routeName);
                          },
                          text: "Signup",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
