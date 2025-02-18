import 'package:expense_tracker/data/datasources/expense_local_data_source.dart';
import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<void> addExpense(Expense expense) async {
    await localDataSource.addExpense(expense);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    return await localDataSource.getExpenses();
  }
}