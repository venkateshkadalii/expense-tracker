
import 'package:flutter/material.dart';

import '../../domain/entities/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          title: Text(expense.title!),
          subtitle: Text(expense.category!),
          trailing: Text("\$${expense.amount}"),
        );
      },
    );
  }
}
