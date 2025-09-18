// data/models/account_balance.dart
class AccountBalance {
  final double totalDeposits;
  final double totalExpenses;
  final double availableBalance;

  AccountBalance({
    required this.totalDeposits,
    required this.totalExpenses,
    required this.availableBalance,
  });

  factory AccountBalance.fromJson(Map<String, dynamic> json) {
    final totalDeposits = json['totalDeposits'] is double ? json['totalDeposits'] : json['totalDeposits'].toDouble();
    final totalExpenses = json['totalExpenses'] is double ? json['totalExpenses'] : json['totalExpenses'].toDouble();
    
    return AccountBalance(
      totalDeposits: totalDeposits,
      totalExpenses: totalExpenses,
      availableBalance: totalDeposits - totalExpenses,
    );
  }
}