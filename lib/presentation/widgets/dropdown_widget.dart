import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final ValueChanged<String> onSelected;
  final String value;

  const DropdownWidget({
    super.key,
    required this.onSelected,
    required this.value,
  });

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
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.category, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: widget.value,
      items:
          categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
      onChanged: (value) => widget.onSelected(value!),
    );
  }
}
