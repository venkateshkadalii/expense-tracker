import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository expenseRepository;

  GetExpensesUseCase(this.expenseRepository);

  Future<List<Expense>> call() async {
    return await expenseRepository.getExpenses();
  }
}