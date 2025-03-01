import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final String date;
  final Color color;

  const TransactionTile({super.key, required this.icon, required this.label, required this.amount, required this.date, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
        trailing: Text(amount, style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}