import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  const CustomTextFieldWidget({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 143, 140, 140),
          ),
        ),
        labelText: label,
      ),
      maxLines: maxLines,
    );
  }
}
