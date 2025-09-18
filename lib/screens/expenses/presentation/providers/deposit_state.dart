// presentation/providers/deposit_state.dart
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';

class DepositState {
  final bool loading;
  final List<CashDeposit> deposits;
  final String? error;

  DepositState({
    required this.loading,
    required this.deposits,
    this.error,
  });

  factory DepositState.initial() =>
      DepositState(loading: false, deposits: []);

  DepositState copyWith({
    bool? loading,
    List<CashDeposit>? deposits,
    String? error,
  }) =>
      DepositState(
        loading: loading ?? this.loading,
        deposits: deposits ?? this.deposits,
        error: error ?? this.error,
      );
}