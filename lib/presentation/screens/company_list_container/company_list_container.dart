import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_state.dart';
import 'package:cargo_linker/presentation/widgets/button_circular_progress_indicator.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_dropdown_field.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyListContainerScreen extends StatelessWidget {
  CompanyListContainerScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final containerIdController = TextEditingController();
  final dueDateController = TextEditingController();
  final containerSizeController = TextEditingController();
  final containerTypeController = TextEditingController();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();

  static const String routeName = "companyListConatinerScreen";

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
                  "List a Container",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
                const Text(
                  "Fill all the details to list your container",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const Spacing(multiply: 6),
                PrimaryTextField(
                  controller: containerIdController,
                  labelText: 'Container Id',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter a your Container Number';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryDropdownField(
                  labelText: "Types of container",
                  items: CONTAINER_TYPES,
                  controller: containerTypeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Container type';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryDropdownField(
                  labelText: 'Size of Container',
                  items: CONTAINER_SIZE_TYPES,
                  controller: containerSizeController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter size of your container';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: PrimaryTextField(
                        controller: lengthController,
                        labelText: 'Length',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: PrimaryTextField(
                        controller: widthController,
                        labelText: 'Width',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: PrimaryTextField(
                        controller: heightController,
                        labelText: 'Height',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: pickupController,
                  labelText: 'Pickup Address',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Pickup Address';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: dropController,
                  labelText: 'Drop Address',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Drop Address';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: dueDateController,
                  labelText: 'Due Date',
                  readOnly: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Due Date';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );

                    if (pickedDate == null) return;
                    dueDateController.text =
                        '${pickedDate.month}-${pickedDate.day}-${pickedDate.year}';
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: priceController,
                  labelText: 'Price',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Price';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 4),
                PrimaryButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<CompanyContainerCubit>(context)
                        .submitContainer(
                            containerId: containerIdController.text,
                            type: containerTypeController.text,
                            size: double.parse(containerSizeController.text
                                .replaceFirst(" Feet", "")),
                            dimensionLength:
                                double.parse(lengthController.text),
                            dimensionWidth: double.parse(widthController.text),
                            dimensionHeigth:
                                double.parse(heightController.text),
                            price: priceController.text,
                            pickupAddress: pickupController.text,
                            dropAddress: dropController.text,
                            due: dueDateController.text);
                  }
                }, child:
                    BlocBuilder<CompanyContainerCubit, CompanyContainerState>(
                  builder: (context, state) {
                    if (state is CompanyContainerLoadingState) {
                      return const ButtonCircularProgressIndicator();
                    }
                    return const Text('List Container');
                  },
                )),
                const Spacing(multiply: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
