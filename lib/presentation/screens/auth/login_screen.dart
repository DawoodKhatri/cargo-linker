import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/screens/auth/signup_screen.dart';
import 'package:cargo_linker/presentation/screens/auth/verification_screen.dart';
import 'package:cargo_linker/presentation/screens/home/home_screen.dart';
import 'package:cargo_linker/presentation/widgets/buttonCircularProgressIndicator.dart';
import 'package:cargo_linker/presentation/widgets/primaryButton.dart';
import 'package:cargo_linker/presentation/widgets/primaryTextButton.dart';
import 'package:cargo_linker/presentation/widgets/primaryTextField.dart';
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
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                          Navigator.pushNamed(context, SignupScreen.routeName);
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
    );
  }
}
