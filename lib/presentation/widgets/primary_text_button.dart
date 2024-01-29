import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const PrimaryTextButton({super.key, this.onPressed, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
