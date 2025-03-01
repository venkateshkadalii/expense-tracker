import 'package:expense_tracker/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker/presentation/bloc/expense_event.dart';
import 'package:expense_tracker/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                  Text(
                    'Total Expenses',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      if (state is ExpenseLoadedState) {
                        return Text(
                          "\₹${state.totalExpenses}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else if (state is ExpenseAddedState) {
                        return Text(
                          "\₹${state.totalExpenses}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Text(
                          "\₹0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,)
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "This Week\n2,500.000",
                  //       style: TextStyle(color: Colors.white, fontSize: 14),
                  //     ),
                  //     Text(
                  //       "Today\n800.00",
                  //       style: TextStyle(color: Colors.white, fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text("View All", style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildExpenseList()),
            // Expanded(
            //   child: ListView(
            //     children: const [
            //       TransactionTile(icon: Icons.fastfood, label: "Food", amount: "-\$45.00", date: "Today", color: Colors.orange),
            //       TransactionTile(icon: Icons.shopping_bag, label: "Shopping", amount: "-\$280.00", date: "Today", color: Colors.purple),
            //       TransactionTile(icon: Icons.movie, label: "Entertainment", amount: "-\$60.00", date: "Yesterday", color: Colors.red),
            //       TransactionTile(icon: Icons.flight, label: "Travel", amount: "-\$250.00", date: "Yesterday", color: Colors.green),
            //     ],
            //   ),
            // ),
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
              final expense = expenses[index]; // Get the current expense
              final category = expense.category?.toLowerCase() ?? "other";

              IconData icon;
              Color color;
              String label = expense.title ?? "Other"; // Default label

              switch (category) {
                case "food":
                  icon = Icons.fastfood;
                  color = Colors.orange;
                  break;
                case "travel":
                  icon = Icons.flight;
                  color = Colors.green;
                  break;
                case "shopping":
                  icon = Icons.shopping_bag;
                  color = Colors.blue;
                  break;
                case "entertainment":
                  icon = Icons.movie;
                  color = Colors.purple;
                  break;
                default:
                  icon = Icons.category;
                  color = Colors.grey;
              }

              return TransactionTile(
                icon: icon,
                label: label,
                amount: "${expense.amount?.toStringAsFixed(2)}",
                // Format amount
                date: expense.date!,
                // Assuming expense.date is already formatted
                color: color,
              );
            },
          );
        } else if (state is ExpenseAddedState) {
          final expenses = state.expenses;
          return ListView.separated(
            itemCount: expenses.length,
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemBuilder: (context, index) {
              final expense = expenses[index]; // Get the current expense
              final category = expense.category?.toLowerCase() ?? "other";

              IconData icon;
              Color color;
              String label = expense.title ?? "Other"; // Default label

              switch (category) {
                case "food":
                  icon = Icons.fastfood;
                  color = Colors.orange;
                  break;
                case "travel":
                  icon = Icons.flight;
                  color = Colors.green;
                  break;
                case "shopping":
                  icon = Icons.shopping_bag;
                  color = Colors.blue;
                  break;
                case "entertainment":
                  icon = Icons.movie;
                  color = Colors.purple;
                  break;
                default:
                  icon = Icons.category;
                  color = Colors.grey;
              }

              return TransactionTile(
                icon: icon,
                label: label,
                amount: "${expense.amount?.toStringAsFixed(2)}",
                // Format amount
                date: expense.date!,
                // Assuming expense.date is already formatted
                color: color,
              );
            },
          );
        } else {
          return Center(child: Text("No expenses found"));
        }
      },
    );
  }
}

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final DateTime date;
  final Color color;

  const TransactionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
    required this.date,
    required this.color,
  });

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
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('dd MMM, yyyy').format(date),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
