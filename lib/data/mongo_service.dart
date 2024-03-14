import 'package:mongo_dart/mongo_dart.dart';
import 'package:intl/intl.dart';

import '../helpers/date_manipulator.dart';

class MongoDBService {
  late Db _db;

  MongoDBService();

  Future<MongoDBService> initialize() async {
    await _connect_to_db();
    return this;
  }

  Future<void> _connect_to_db() async {
    const String uri = "mongodb+srv://tzongwei2:027174gG@herbsfyp.4iqhrrw.mongodb.net/budget?retryWrites=true&w=majority";
    _db = await Db.create(uri);
    await _db.open();
  }

  Future<List<Map<String, dynamic>>> getExpenses(DateTime date) async {
    if (_db == null || !_db.isConnected) {
      await _connect_to_db();
    }

    Map<String, DateTime> currentMonth = getCurrentMonthSg(date);
    DateTime startOfMonth = currentMonth['startOfMonth']!;
    DateTime endOfMonth = currentMonth['endOfMonth']!;

    final List<Map<String, dynamic>> expenses = [];
    final cursor = _db.collection('expense').find({
      'date': {
        '\$gte': startOfMonth,
        '\$lte': endOfMonth
      }
    });

    await cursor.forEach((expense) {
      expenses.add(expense);
    });
    return expenses;
  }
}


void main() async {
  final databaseService = MongoDBService();
  await databaseService.initialize();
  try {

    final expenses = await databaseService.getExpenses(DateTime.now());
    print('Expenses: $expenses');
  } catch (e) {
    print('An error occurred: $e');
  }
}
