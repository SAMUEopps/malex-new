// presentation/providers/deposit_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malex_new/screens/expenses/data/repositories/deposit_repository_impl.dart';
import 'package:malex_new/screens/expenses/data/datasources/deposit_remote_ds.dart';
import 'package:malex_new/screens/expenses/domain/repositories/deposit_repository.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'deposit_state.dart';

final depositRepositoryProvider = Provider<DepositRepository>((ref) {
  return DepositRepositoryImpl(DepositRemoteDataSource());
});

final depositNotifierProvider =
    StateNotifierProvider<DepositNotifier, DepositState>((ref) {
  final repo = ref.watch(depositRepositoryProvider);
  return DepositNotifier(repo);
});

class DepositNotifier extends StateNotifier<DepositState> {
  final DepositRepository _repo;

  DepositNotifier(this._repo) : super(DepositState.initial()) {
    fetchDeposits();
  }

  Future<void> fetchDeposits() async {
    state = state.copyWith(loading: true, error: null);
    final result = await _repo.getDeposits();
    result.fold(
      (failure) => state = state.copyWith(loading: false, error: 'Fetch failed'),
      (list) => state = state.copyWith(loading: false, deposits: list),
    );
  }

  Future<void> addDeposit(CashDeposit deposit) async {
    final result = await _repo.addDeposit(deposit);
    result.fold(
      (failure) => state = state.copyWith(error: 'Add failed'),
      (newDeposit) => state = state.copyWith(deposits: [newDeposit, ...state.deposits]),
    );
  }

  Future<void> updateDeposit(CashDeposit deposit) async {
    final result = await _repo.updateDeposit(deposit);
    result.fold(
      (failure) => state = state.copyWith(error: 'Update failed'),
      (updated) {
        final list = state.deposits.map((d) => d.id == updated.id ? updated : d).toList();
        state = state.copyWith(deposits: list);
      },
    );
  }

  Future<void> deleteDeposit(String id) async {
    final result = await _repo.deleteDeposit(id);
    result.fold(
      (failure) => state = state.copyWith(error: 'Delete failed'),
      (_) => state = state.copyWith(
          deposits: state.deposits.where((d) => d.id != id).toList()),
    );
  }
}