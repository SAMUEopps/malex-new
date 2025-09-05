class Expense {
  final DateTime date;
  final double amount;
  final String description;
  final String category;
  final String vendor;
  final String paymentMethod;
  final String receipt;

  Expense(this.date, this.amount, this.description, this.category, this.vendor,
      this.paymentMethod, this.receipt);
}