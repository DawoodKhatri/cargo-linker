import 'package:cargo_linker/presentation/widgets/primary_text_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PrimaryFilePickerField extends StatefulWidget {
  final String labelText;
  final Function(String) onPick;
  const PrimaryFilePickerField(
      {super.key, required this.labelText, required this.onPick});

  @override
  State<PrimaryFilePickerField> createState() => _PrimaryFilePickerFieldState();
}

class _PrimaryFilePickerFieldState extends State<PrimaryFilePickerField> {
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade700)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName ?? widget.labelText,
            style: const TextStyle(fontSize: 16),
          ),
          PrimaryTextButton(
            text: "Select File",
            onPressed: () async {
              FilePickerResult? pickedFile =
                  await FilePicker.platform.pickFiles();
              if (pickedFile == null) return;
              setState(() {
                fileName = pickedFile.files.single.name;
              });

              widget.onPick(pickedFile.paths.single.toString());
            },
          )
        ],
      ),
    );
  }
}
