import 'package:expense_tracker/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker/presentation/bloc/expense_event.dart';
import 'package:expense_tracker/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense.dart';
import '../widgets/expense_list.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpenseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker"),),
      // body: BlocBuilder<ExpenseBloc, ExpenseState>(
      //   builder: (context, state) {
      //     if (state is ExpenseLoadingState) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (state is ExpenseLoadedState) {
      //       return ExpenseList(expenses: state.expenses);
      //     } else if (state is ExpenseErrorState) {
      //       return Center(child: Text(state.message));
      //     } else if(state is ExpenseAddedState) {
      //       return ExpenseList(expenses: state.expenses);
      //     }
      //     return Center(child: Text("No expenses available"));
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTotalSpent(),
            SizedBox(height: 20),
            Expanded(child: _buildExpenseList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTotalSpent() {
    return Column(
      children: [
        Text(
          "Spent this week",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          "\$292.50", // This should be dynamically calculated
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseList() {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoadedState) {
          final expenses = state.expenses;
          return ListView.separated(
            itemCount: expenses.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return _buildExpenseItem(expenses[index]);
            },
          );
        } else if(state is ExpenseAddedState) {
          final expenses = state.expenses;
          return ListView.separated(
            itemCount: expenses.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return _buildExpenseItem(expenses[index]);
            },
          );
        }
        else {
          return Center(child: Text("No expenses found"));
        }
      },
    );
  }

  Widget _buildExpenseItem(Expense expense) {
    // final currencyFormat = NumberFormat.currency(symbol: "\$");
    final isIncome = expense.amount! > 0;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.shopping_bag, color: Colors.black),
      ),
      title: Text(expense.title!, style: TextStyle(fontSize: 16)),
      subtitle: Text(
        expense.date.toString(),
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        "${expense.amount}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isIncome ? Colors.green : Colors.black,
        ),
      ),
    );
  }
}
