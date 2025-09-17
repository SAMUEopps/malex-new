class CashDeposit {
  final String source;
  final double amount;
  final DateTime date;
  final String? notes;

  CashDeposit({
    required this.source,
    required this.amount,
    required this.date,
    this.notes,
  });
}