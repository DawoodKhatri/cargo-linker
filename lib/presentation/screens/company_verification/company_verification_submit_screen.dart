import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:cargo_linker/presentation/screens/company_verification/company_verification_status_screen.dart';
import 'package:cargo_linker/presentation/widgets/button_circular_progress_indicator.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_dropdown_field.dart';
import 'package:cargo_linker/presentation/widgets/primary_file_picker_field.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyVerificationSubmitScreen extends StatelessWidget {
  CompanyVerificationSubmitScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final establishmentDateController = TextEditingController();
  final serviceTypeController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final valuationController = TextEditingController();
  final licenseController = TextEditingController();
  final bankStatementController = TextEditingController();

  static const String routeName = "companyVerificationSubmit";

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyVerificationCubit, CompanyVerificationState>(
      listener: (context, state) {
        if (state is CompanyVerificationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is CompanyVerificationOngoingState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(
              context, CompanyVerificationStatusScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CargoLinker"),
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
                    "Get Verified",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                  const Text(
                    "Submit and get your company details verified",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const Spacing(multiply: 6),
                  PrimaryTextField(
                    controller: nameController,
                    labelText: 'Company Name',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),

                  const Spacing(multiply: 3),
                  PrimaryTextField(
                    controller: establishmentDateController,
                    labelText: 'Establishment Date',
                    readOnly: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter establishment date';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(0),
                        lastDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );

                      if (pickedDate == null) return;
                      establishmentDateController.text =
                          '${pickedDate.month}-${pickedDate.day}-${pickedDate.year}';
                    },
                  ),
                  const Spacing(multiply: 3),
                  PrimaryTextField(
                    controller: registrationNumberController,
                    labelText: 'Registration Number',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter registration number';
                      }
                      return null;
                    },
                  ),

                  const Spacing(multiply: 3),
                  PrimaryDropdownField(
                    labelText: "Service Type",
                    items: SERVICE_TYPES,
                    controller: serviceTypeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter service type';
                      }
                      return null;
                    },
                  ),

                  const Spacing(multiply: 3),

                  PrimaryFilePickerField(
                      labelText: "License",
                      onPick: (filePath) {
                        licenseController.text = filePath;
                      }),
                  const Spacing(multiply: 3),

                  PrimaryFilePickerField(
                      labelText: "Bank Statement",
                      onPick: (filePath) {
                        bankStatementController.text = filePath;
                      }),

                  const Spacing(multiply: 4),
                  PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<CompanyVerificationCubit>(context)
                            .submitDetails(
                                nameController.text.trim(),
                                establishmentDateController.text.trim(),
                                registrationNumberController.text.trim(),
                                serviceTypeController.text.trim(),
                                licenseController.text.trim(),
                                bankStatementController.text.trim());
                      }
                    },
                    child: BlocBuilder<CompanyVerificationCubit,
                        CompanyVerificationState>(
                      builder: (context, state) {
                        if (state is CompanyVerificationLoadingState) {
                          return const ButtonCircularProgressIndicator();
                        }
                        return const Text('Submit Details');
                      },
                    ),
                  ),
                  const Spacing(multiply: 4),
                  // const Spacing(multiply: 2),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text("Don't have an account ?"),
                  //     const Spacing(),
                  //     PrimaryTextButton(
                  //       onPressed: () {
                  //         // Navigator.pushNamed(context, SignupScreen.routeName);
                  //       },
                  //       text: "Signup",
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
