import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/data/datasources/expense_remote_ds.dart';
import 'package:malex_new/screens/expenses/data/repositories/expense_repo_impl.dart';
import '../../domain/repositories/expense_repository.dart';
import 'expense_state.dart';

/* ------------------------------------------------------------------ */
/* 1.  Repository Provider                                            */
/* ------------------------------------------------------------------ */
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  // ---- import your concrete implementation ----
  // Example:
  // import '../data/expense_repository_impl.dart';
  // import '../data/datasources/expense_remote_ds.dart';
  return ExpenseRepositoryImpl(ExpenseRemoteDataSource());
});

/* ------------------------------------------------------------------ */
/* 2.  State / Notifier                                               */
/* ------------------------------------------------------------------ */
final expenseNotifierProvider =
    StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
  final repo = ref.watch(expenseRepositoryProvider);
  return ExpenseNotifier(repo);
});

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  final ExpenseRepository _repo;

  ExpenseNotifier(this._repo) : super(ExpenseState.initial()) {
    fetchExpenses();
  }

  /* -------------------- CRUD methods -------------------- */

  Future<void> fetchExpenses() async {
    state = state.copyWith(loading: true, error: null);
    final result = await _repo.getExpenses();
    result.fold(
      (failure) => state = state.copyWith(loading: false, error: 'Fetch failed'),
      (list) => state = state.copyWith(loading: false, expenses: list),
    );
  }

  Future<void> addExpense(Expense expense) async {
    final result = await _repo.addExpense(expense);
    result.fold(
      (failure) => state = state.copyWith(error: 'Add failed'),
      (newExp) => state = state.copyWith(expenses: [newExp, ...state.expenses]),
    );
  }

  Future<void> updateExpense(Expense expense) async {
    final result = await _repo.updateExpense(expense);
    result.fold(
      (failure) => state = state.copyWith(error: 'Update failed'),
      (updated) {
        final list = state.expenses.map((e) => e.id == updated.id ? updated : e).toList();
        state = state.copyWith(expenses: list);
      },
    );
  }

  Future<void> deleteExpense(String id) async {
    final result = await _repo.deleteExpense(id);
    result.fold(
      (failure) => state = state.copyWith(error: 'Delete failed'),
      (_) => state = state.copyWith(
          expenses: state.expenses.where((e) => e.id != id).toList()),
    );
  }
}

extension on Object? {
}