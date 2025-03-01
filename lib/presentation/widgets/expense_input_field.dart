import 'package:flutter/material.dart';

class ExpenseInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  const ExpenseInputField({super.key, required this.icon, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}