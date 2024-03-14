import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                "Feb",
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
                '\$${state.totalExpenses.toString()}',
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              )
            ])),
      ),
      Divider(),
      Expanded(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.expenses.length,
            itemBuilder: (context, index) {
              Expense expense = state.expenses[index];
              return _buildExpenseItem(expense: expense);
            }),
      ),
    ]);}
        else {
          return Center(child: Text('Unknown state'));
        }}));}
  }

  Widget _buildExpenseItem({required Expense expense}) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
          child: InkWell(
              onTap: () {
                // Your existing onTap logic here
              },
              child: Column(children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.all(1), // Border width
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/zy.jpeg'),
                      radius: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children:  [
                            Text(expense.category),
                            const SizedBox(width:8),
                            const Icon(Icons.sports_esports,
                                size: 20, color: Colors.blue)
                          ]),
                          const SizedBox(height:10),
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
                  Text('\$${expense.expense.toString()}')
                ]),
                const Divider()
              ]))),
    );
  }

