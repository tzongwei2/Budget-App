part of 'expenses_bloc.dart';

class ExpenseState extends Equatable{
  @override
  List<Object?> get props => [];

}

class ExpenseLoading extends ExpenseState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ExpenseEmpty extends ExpenseState {

}

class ExpenseError extends ExpenseState {

}


class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final double totalExpenses;

  ExpenseLoaded(this.expenses, this.totalExpenses);

  @override
  List<Object?> get props => [expenses,totalExpenses];
}