import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String selectedCategory = "Food";
  final List<String> categories = [
    "Food",
    "Shopping",
    "Entertainment",
    "Travel",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.category, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: selectedCategory,
      items:
          categories.map((category) {
            return DropdownMenuItem(
                value: category, child: Text(category));
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value as String;
        });
      },
    );
  }
}
