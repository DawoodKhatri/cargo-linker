import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  const PrimaryTextField({
    super.key,
    this.controller,
    this.labelText,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: labelText,
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
