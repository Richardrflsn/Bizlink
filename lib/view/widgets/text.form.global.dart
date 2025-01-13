import 'package:flutter/material.dart';

class TextFormGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPasswordField;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;
  final TextInputType keyboardType;

  const TextFormGlobal({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPasswordField = false,
    this.isPasswordVisible = false,
    required this.togglePasswordVisibility,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField ? !isPasswordVisible : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: togglePasswordVisibility,
        )
            : null,
      ),
    );
  }
}
