import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/authentication/auth_bloc.dart';
import '../blocs/expenses/expenses_bloc.dart';
import '../data/models/expense_model.dart';


class ExpenseFeedScreen extends StatefulWidget {
  const ExpenseFeedScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseFeedScreen> createState() => _ExpenseFeedScreenState();
}

class _ExpenseFeedScreenState extends State<ExpenseFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
        if (state is ExpenseEmpty) {
          BlocProvider.of<ExpenseBloc>(context).add(FetchExpenses(DateTime.now()));
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoaded) {
       return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        height: 80,
        //Color.fromRGBO(243, 175, 77, 1),
        color: Colors.white70, //Color.fromRGBO(243, 175, 77, 1),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 35, right: 20),
            child: Row(children:  [
              InkWell(
                  child: Icon(Icons.arrow_left, color: Colors.black, size: 35)),
              Text(
                '${DateFormat('MMM yy').format(DateTime.now())}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              const InkWell(
                  child:
                      Icon(Icons.arrow_right, color: Colors.black, size: 35)),
              const Spacer(),
              Text(
                '\$${state.totalExpenses.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              )
            ])),
      ),
         const  Divider(
           height: 1,
           thickness: 0.5,
           color: Colors.grey,
         ),
      Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: state.groupedExpensesByDay.length,
            itemBuilder: (context, index) {
              DateTime day = state.groupedExpensesByDay.keys.elementAt(index);
              List<Expense> expenses = state.groupedExpensesByDay[day]!;
            return _buildDayCard(day: day, expenses: expenses);
            },
      ),
      )]);}
        else {
          return const Center(child: Text('Unknown state'));
        }}));}
  }

Widget _buildDayCard({required DateTime day, required List<Expense> expenses}) {
  final totalDayExpenses = expenses.fold<double>(
    0, (sum, expense) => sum + expense.expense);
  return Card(
    color: totalDayExpenses > 160? Colors.red.shade200.withOpacity(0.5) : Colors.white,
    elevation: 3,
    margin: const EdgeInsets.all(6),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(
                '${day.year}-${day.month}-${day.day}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              Row(children: [Text('${DateFormat('EEE').format(day)}: ',
                  style: TextStyle(color : totalDayExpenses > 100? Colors.red.shade900 : Colors.black)),
                Text('\$${totalDayExpenses.toStringAsFixed(2)}',
              style: TextStyle(color : totalDayExpenses > 100? Colors.red.shade900 : Colors.black, fontWeight: FontWeight.bold),) ])]
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              Expense expense = expenses[index];
              return _buildExpenseItem(expense: expense);
            },
          ),
        ],
      ),
    ),
  );
}


  Widget _buildExpenseItem({required Expense expense}) {
    return
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
          child: InkWell(
              onTap: () {
                // Your existing onTap logic here
              },
              child: Column(children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.all(1), // Border width
                    decoration:  BoxDecoration(
                      color:  expense.user == 'WG Zi Yi'? Colors.pink: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child:

                       CircleAvatar(
                      backgroundImage: expense.user == 'WG Zi Yi'? const AssetImage('assets/zy.jpeg') : const AssetImage('assets/zw.jpeg'),
                      radius: 22,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children:  [
                            Text(expense.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            const SizedBox(width:8),
                            const Icon(Icons.sports_esports,
                                size: 20, color: Colors.blue)
                          ]),
                          const SizedBox(height:6),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth:
                                    240, // Maximum width this widget can take
                              ),
                              child:  Text(
                               expense.description
                              )),
                        ]),
                  ),
                  const Spacer(),
                  Text('\$${expense.expense.toStringAsFixed(2)}')
                ]),
                const SizedBox(height:5),
                const  Divider(
                  height: 1,
                  thickness: 0.6,
                  color: Colors.grey,
                ),
              ])));
  }

