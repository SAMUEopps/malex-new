// presentation/providers/account_balance_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malex_new/screens/expenses/data/models/account_balance.dart';

final accountBalanceProvider = StateProvider<AccountBalance>((ref) {
  return AccountBalance(
    totalDeposits: 0,
    totalExpenses: 0,
    availableBalance: 0,
  );
});

// Helper function to update account balance
void updateAccountBalance(WidgetRef ref, {double? depositChange, double? expenseChange}) {
  final currentBalance = ref.read(accountBalanceProvider);
  
  double newTotalDeposits = currentBalance.totalDeposits;
  double newTotalExpenses = currentBalance.totalExpenses;
  
  if (depositChange != null) {
    newTotalDeposits += depositChange;
  }
  
  if (expenseChange != null) {
    newTotalExpenses += expenseChange;
  }
  
  ref.read(accountBalanceProvider.notifier).state = AccountBalance(
    totalDeposits: newTotalDeposits,
    totalExpenses: newTotalExpenses,
    availableBalance: newTotalDeposits - newTotalExpenses,
  );
}