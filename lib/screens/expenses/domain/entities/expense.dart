class Expense {
  final String id;
  final double amount;
  final DateTime date;
  final String description;
  final String vendor;
  final String category;
  final String paymentMethod;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
    required this.vendor,
    required this.category,
    required this.paymentMethod,
  });
}