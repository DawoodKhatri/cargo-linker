import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/widgets/buttonCircularProgressIndicator.dart';
import 'package:cargo_linker/presentation/widgets/primaryButton.dart';
import 'package:cargo_linker/presentation/widgets/primaryTextButton.dart';
import 'package:cargo_linker/presentation/widgets/primaryTextField.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  static const routeName = "signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGNUP"),
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
                  "Hello, Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
                const Text(
                  "Fill your details to signup for an account",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const Spacing(multiply: 6),
                PrimaryTextField(
                  controller: emailController,
                  labelText: "Email",
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
                  labelText: "Password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: repasswordController,
                  labelText: "Re-type Password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please re-enter password';
                    } else if (value.trim() != passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 4),
                PrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthCubit>(context).emailVerify(
                          emailController.text.trim(),
                          passwordController.text.trim());
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const ButtonCircularProgressIndicator();
                      }
                      return const Text('Continue');
                    },
                  ),
                ),
                const Spacing(multiply: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const Spacing(),
                    PrimaryTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Login",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
