import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/expense_model.dart';
import '../../data/repos/expenses_repository.dart';
part 'expense_event.dart';
part 'expense_state.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({required this.expenseRepository}) : super(ExpenseEmpty()){
    on<FetchExpenses>((event, emit) async {
      emit(ExpenseLoading());
      try {

        final expenses = await expenseRepository.fetchExpenses(event.date);
        double totalExpenses = expenses.fold(0, (sum, expense) => sum + expense.expense);
        emit(ExpenseLoaded(expenses,totalExpenses));

      } catch (e) {
        // Handle error
        emit(ExpenseEmpty());
        print('Error Loading Expenses $e');
      }
    });
  }
}

