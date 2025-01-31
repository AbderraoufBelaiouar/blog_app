import 'package:flutter/material.dart';

class Authfield extends StatelessWidget {
  const Authfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText is missing!';
        }
        return null;
      },
    );
  }
}
