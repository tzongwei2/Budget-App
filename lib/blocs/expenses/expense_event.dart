part of 'expenses_bloc.dart';

class ExpenseEvent extends Equatable{

  const ExpenseEvent();

  @override
  List<Object> get props =>[];
}


class AddExpense extends ExpenseEvent{
  final Expense expense;
  const AddExpense({
    required this.expense
  });

  @override
  // TODO: implement props
  List<Object> get props => [expense];
}

class FetchExpenses extends ExpenseEvent {
  final DateTime date;

  const FetchExpenses(this.date);

  @override
  List<Object> get props => [date];
}
