import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository expenseRepository;

  AddExpenseUseCase(this.expenseRepository);

  Future<void> call(Expense expense) async {
    return await expenseRepository.addExpense(expense);
  }
}