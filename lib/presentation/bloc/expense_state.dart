import 'package:expense_tracker/domain/entities/expense.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  final List<Expense> expenses;
  ExpenseLoadedState(this.expenses);
}

class ExpenseErrorState extends ExpenseState {
  final String message;
  ExpenseErrorState(this.message);
}

class ExpenseAddedState extends ExpenseState {
  final List<Expense> expenses;

  ExpenseAddedState(this.expenses);
}