import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/widgets/buttonCircularProgressIndicator.dart';
import 'package:cargo_linker/presentation/widgets/primaryButton.dart';
import 'package:cargo_linker/presentation/widgets/primaryDropdownField.dart';
import 'package:cargo_linker/presentation/widgets/primaryTextField.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

class CompanySubmitVerificationScreen extends StatelessWidget {
  CompanySubmitVerificationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final serviceTypeController = TextEditingController();
  final establishmentDateController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final employeesCountController = TextEditingController();
  final valuationController = TextEditingController();
  final licenseController = TextEditingController();
  final bankStatemenrController = TextEditingController();

  static const String routeName = "companySubmitVerification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                PrimaryDropdownField(
                  labelText: "Service Type",
                  items: SERVICE_TYPES,
                  controller: serviceTypeController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter service type';
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
                        '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
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
                PrimaryTextField(
                  controller: employeesCountController,
                  labelText: 'Employees Count',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter employees count';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: valuationController,
                  labelText: 'Company Valuation',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter company valuation';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: licenseController,
                  readOnly: true,
                  labelText: 'Licence',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please pick license';
                    }
                    return null;
                  },
                  onTap: () async {
                    FilePickerResult? pickedFile = await FilePicker.platform
                        .pickFiles();
                    if (pickedFile == null) return;
                    print(pickedFile.files);
                    licenseController.text = pickedFile.files.single.name;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: bankStatemenrController,
                  readOnly: true,
                  labelText: 'Bank Statement',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please pick bank statement';
                    }
                    return null;
                  },
                  onTap: () async {
                    FilePickerResult? pickedFile = await FilePicker.platform
                        .pickFiles();
                    if (pickedFile == null) return;
                    print(pickedFile.files);
                    bankStatemenrController.text = pickedFile.files.single.name;
                  },
                ),

                const Spacing(multiply: 4),
                PrimaryButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   BlocProvider.of<AuthCubit>(context).login(
                    //       emailController.text.trim(),
                    //       passwordController.text.trim());
                    // }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const ButtonCircularProgressIndicator();
                      }
                      return const Text('Submit Details');
                    },
                  ),
                ),
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
    );
  }
}
