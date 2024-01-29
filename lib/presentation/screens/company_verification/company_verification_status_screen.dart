import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_submit_screen.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyVerificationStatusScreen extends StatelessWidget {
  const CompanyVerificationStatusScreen({super.key});

  static const String routeName = "companyVerificationStatus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Status"),
        centerTitle: true,
      ),
      body: BlocBuilder<CompanyVerificationCubit, CompanyVerificationState>(
          builder: (context, state) {
        if (state is CompanyVerificationOngoingState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.status,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  if (state.status ==
                      VERIFICATION_STATUS.underVerification) ...[
                    const Text(
                      "Your account is under review, it will be verified within 7 working days",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacing(
                      multiply: 2,
                    ),
                    PrimaryButton(
                      child: const Text("Exit App"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    )
                  ],
                  if (state.status == VERIFICATION_STATUS.rejected) ...[
                    Text(
                      state.message ?? "",
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const Spacing(
                      multiply: 2,
                    ),
                    PrimaryButton(
                      child: const Text("Reverify"),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CompanyVerificationSubmitScreen.routeName);
                      },
                    )
                  ]
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
