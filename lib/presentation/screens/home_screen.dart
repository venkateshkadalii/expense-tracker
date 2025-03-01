import 'package:expense_tracker/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker/presentation/bloc/expense_event.dart';
import 'package:expense_tracker/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int currentPageIndex = 0;

  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpenseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Welcome!", style: TextStyle(color: Colors.grey)),
            const Text(
              "Venkatesh Kadali",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('This Month Expenses', style: TextStyle(color: Colors.white, fontSize: 16),),
                  SizedBox(height: 8,),
                  Text("\₹4800.00", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("This Week\n2,500.000", style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text("Today\n800.00", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("View All", style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  TransactionTile(icon: Icons.fastfood, label: "Food", amount: "-\$45.00", date: "Today", color: Colors.orange),
                  TransactionTile(icon: Icons.shopping_bag, label: "Shopping", amount: "-\$280.00", date: "Today", color: Colors.purple),
                  TransactionTile(icon: Icons.movie, label: "Entertainment", amount: "-\$60.00", date: "Yesterday", color: Colors.red),
                  TransactionTile(icon: Icons.flight, label: "Travel", amount: "-\$250.00", date: "Yesterday", color: Colors.green),
                ],
              ),
            ),
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
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
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
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
        } else if (state is ExpenseAddedState) {
          final expenses = state.expenses;
          return ListView.separated(
            itemCount: expenses.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return _buildExpenseItem(expenses[index]);
            },
          );
        } else {
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

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final String date;
  final Color color;

  const TransactionTile({super.key, required this.icon, required this.label, required this.amount, required this.date, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
        trailing: Text(amount, style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
