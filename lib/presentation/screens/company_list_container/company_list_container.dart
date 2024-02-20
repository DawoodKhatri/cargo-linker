import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_dropdown_field.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CompanyListContainerScreen extends StatelessWidget {
  CompanyListContainerScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final containerNumberController = TextEditingController();
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
                  controller: containerNumberController,
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
                  labelText: 'Pickup Location',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Pickup Location';
                    }
                    return null;
                  },
                ),
                const Spacing(multiply: 3),
                PrimaryTextField(
                  controller: dropController,
                  labelText: 'Drop Location',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter the Drop Location';
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
                PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Submit Details')),
                const Spacing(multiply: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
