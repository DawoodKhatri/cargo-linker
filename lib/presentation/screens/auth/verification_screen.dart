import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/widgets/button_circular_progress_indicator.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  static const routeName = "otp_verification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EMAIL VERIFICATION"),
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
                  "Almost Done!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
                const Text(
                  "Enter 6-digit verification code sent on",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  BlocProvider.of<AuthCubit>(context).email,
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Row(
                  children: [
                    const Text("Incorrect Email ?"),
                    const Spacing(),
                    PrimaryTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Change",
                    ),
                  ],
                ),
                const Spacing(multiply: 6),
                PrimaryTextField(
                  controller: otpController,
                  labelText: 'One Time Password (OTP)',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your OTP';
                    } else if (value.trim().length != 6) {
                      return 'Please enter your 6 digit OTP';
                    }
                    return null;
                  },
                ),
                const Spacing(),
                Center(
                  child: 1 == 2
                      ? const Text("Resend OTP in 59s")
                      : PrimaryTextButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context)
                                .resendEmailVerification();
                          },
                          text: "Resend OTP",
                        ),
                ),
                const Spacing(multiply: 3),
                PrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthCubit>(context).signup(
                          BlocProvider.of<AuthCubit>(context).email,
                          BlocProvider.of<AuthCubit>(context).password,
                          otpController.text.trim());
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const ButtonCircularProgressIndicator();
                      }
                      return const Text('Signup');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
