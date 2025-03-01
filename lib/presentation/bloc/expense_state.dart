import 'package:expense_tracker/domain/entities/expense.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  final List<Expense> expenses;
  final double totalExpenses;
  ExpenseLoadedState(this.expenses, this.totalExpenses);
}

class ExpenseErrorState extends ExpenseState {
  final String message;
  ExpenseErrorState(this.message);
}

class ExpenseAddedState extends ExpenseState {
  final List<Expense> expenses;
  final double totalExpenses;

  ExpenseAddedState(this.expenses, this.totalExpenses);
}