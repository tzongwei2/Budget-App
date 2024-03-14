import '../models/expense_model.dart';
import '../mongo_service.dart';

class ExpenseRepository{
  final database = MongoDBService();

  ExpenseRepository();

  Future<List<Expense>> fetchExpenses(DateTime date) async {
    await database.initialize();
    final List<Map<String, dynamic>> documents = await database.getExpenses(date);

    List<Expense> expenses = documents.map((doc) => Expense(
      id: doc['_id'].toString(),
      expense: doc['expense'] as double,
      category: doc['category'].toString(),
      user: doc['user'].toString(),
      date: doc['date'] as DateTime,
      description: doc['description'].toString(),
    )).toList();

    // Sort expenses by date
    expenses.sort((b, a) => a.date.compareTo(b.date));

    return expenses;
  }
  //TODO ADD,DELETE,MODIFY,PAGINATION
}

// void main() async {
//   final expenseRepository = await ExpenseRepository();
//
//   try {
//     final expenses = await expenseRepository.fetchExpenses(DateTime.now());
//     print('Fetched Expenses:');
//     expenses.forEach((expense) {
//       print('ID: ${expense.id}');
//       print('Expense: ${expense.expense}');
//       print('Category: ${expense.category}');
//       print('User: ${expense.user}');
//       print('Date: ${expense.date}');
//       print('Description: ${expense.description}');
//       print('-------------------------');
//     });
//   } catch (e) {
//     print('Error fetching expenses: $e');
//   }
// }
