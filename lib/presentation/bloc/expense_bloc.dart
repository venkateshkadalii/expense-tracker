import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/usecases/add_expense.dart';
import 'package:expense_tracker/domain/usecases/get_expenses.dart';
import 'package:expense_tracker/presentation/bloc/expense_event.dart';
import 'package:expense_tracker/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpensesUseCase getExpensesUseCase;
  final AddExpenseUseCase addExpenseUseCase;

  ExpenseBloc(this.getExpensesUseCase, this.addExpenseUseCase) : super(ExpenseInitialState()) {
    on<LoadExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        final expenses = await getExpensesUseCase();
        _calculateTotalExpense(emit, expenses);
        // emit(ExpenseLoadedState(expenses));
      } catch(e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        await addExpenseUseCase(event.expense);
        final expenses = await getExpensesUseCase();
        double total = expenses.fold(0, (sum, expense) => sum + expense.amount!);
        emit(ExpenseAddedState(expenses, total));
      } catch(e) {
        print(e);
        emit(ExpenseErrorState(e.toString()));
      }
    });
  }

  void _calculateTotalExpense(Emitter<ExpenseState> emit, List<Expense> expenses) {
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount!);
    emit(ExpenseLoadedState(expenses, total));
  }
}