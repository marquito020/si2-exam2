import 'package:flutter/material.dart';

export "login_input_decortation_ui.dart";

InputDecoration inputDecoration({
  required String hintText,
  required String labelText,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    alignLabelWithHint: true,
    hintStyle: TextStyle(color: Colors.grey[500]),
    labelStyle: TextStyle(color: Colors.grey[500]),
    suffixIcon:
        suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[500]) : null,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade800),
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  );
}
