import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/domain/usecases/get_expenses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Repository
class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late GetExpensesUseCase getExpensesUseCase;
  late MockExpenseRepository mockExpenseRepository;
  
  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    getExpensesUseCase = GetExpensesUseCase(mockExpenseRepository);
  });

  final List<Expense> testExpenses = [
    Expense(id: "1", title: "Food", amount: 10.0, category: "Groceries", date: DateTime(2024, 2, 10)),
    Expense(id: "2", title: "Transport", amount: 5.0, category: "Travel", date: DateTime(2024, 2, 11)),
  ];

  test('should return list of expenses from repository', () async {
    // Arrange
    when(() => mockExpenseRepository.getExpenses()).thenAnswer((_) async => testExpenses);

    // Act
    final result = await getExpensesUseCase();

    // Assert
    expect(result, equals(testExpenses));
    verify(() => mockExpenseRepository.getExpenses()).called(1);
    verifyNoMoreInteractions(mockExpenseRepository);
  });
}