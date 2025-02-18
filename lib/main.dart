import 'package:expense_tracker/data/datasources/expense_local_data_source.dart';
import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/usecases/add_expense.dart';
import 'package:expense_tracker/domain/usecases/get_expenses.dart';
import 'package:expense_tracker/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Hive.initFlutter();
  Hive.registerAdapter<ExpenseModel>(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('expenseBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => ExpenseBloc(
        GetExpensesUseCase(ExpenseRepositoryImpl(ExpenseLocalDataSource())),
        AddExpenseUseCase(ExpenseRepositoryImpl(ExpenseLocalDataSource()))
      ))
    ], child: MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    ));
  }
}