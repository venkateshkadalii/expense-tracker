import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';

class ExpenseLocalDataSource {
  final Box<ExpenseModel> expenseBox = Hive.box('expenseBox');

  Future<List<Expense>> getExpenses() async {
    return expenseBox.values.toList();
  }

  Future<void> addExpense(Expense expense) async {
    // await expenseBox.put(expense.id, expense);
    var box = Hive.box<ExpenseModel>('expenseBox');
    await box.add(ExpenseModel.fromEntity(expense));
  }
}