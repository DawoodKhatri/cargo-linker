import 'package:flutter/material.dart';

class PrimaryDropdownField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final List<String> items;
  final String? Function(String?)? validator;
  const PrimaryDropdownField(
      {super.key,
      this.controller,
      this.labelText,
      required this.items,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: items
          .map(
            (item) => DropdownMenuEntry(
              value: item,
              label: item,
            ),
          )
          .toList(),
      label: Text(labelText ?? ""),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: controller,
    );
  }
}
