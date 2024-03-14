import 'package:mongo_dart/mongo_dart.dart';

class Expense {
  final String id;
  final double expense;
  final String category;
  final String user;
  final DateTime date;
  final String description;
  final double? income;

  Expense({
    required this.id,
    required this.expense,
    required this.category,
    required this.user,
    required this.date,
    required this.description,
    this.income,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    var id = json['_id'];
    String idStr = id is ObjectId ? id.toHexString() : id.toString();
    return Expense(
      id: idStr,
      expense: json['expense'] as double,
      category: json['category'] as String,
      user: json['user'] as String,
      date: json['date'],
      description: json['description'] as String,
      income: json['income'] as double?, // Parse income field as double or null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'expense': expense,
      'category': category,
      'user': user,
      'date': date.toIso8601String(),
      'description': description,
      'income': income, // Include income field if it's not null
    };
  }
}
