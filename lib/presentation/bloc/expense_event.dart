import 'package:expense_tracker/domain/entities/expense.dart';

abstract class ExpenseEvent {}

class LoadExpenseEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;
  AddExpenseEvent(this.expense);
}