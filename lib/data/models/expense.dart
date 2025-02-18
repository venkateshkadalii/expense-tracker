import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:hive_flutter/adapters.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends Expense {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final DateTime date;

  ExpenseModel({required this.id, required this.title, required this.amount, required this.category, required this.date}) : super(id: id, title: title, amount: amount, category: category, date: date);

  factory ExpenseModel.fromEntity(Expense entity) {
    return ExpenseModel(id: entity.id!, title: entity.title!, amount: entity.amount!, category: entity.category!, date: entity.date!);
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}