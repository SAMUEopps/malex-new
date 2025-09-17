import '../../domain/entities/expense.dart';

class ExpenseState {
  final bool loading;
  final List<Expense> expenses;
  final String? error;

  ExpenseState({
    required this.loading,
    required this.expenses,
    this.error,
  });

  factory ExpenseState.initial() =>
      ExpenseState(loading: false, expenses: []);

  ExpenseState copyWith({
    bool? loading,
    List<Expense>? expenses,
    String? error,
  }) =>
      ExpenseState(
        loading: loading ?? this.loading,
        expenses: expenses ?? this.expenses,
        error: error ?? this.error,
      );
}