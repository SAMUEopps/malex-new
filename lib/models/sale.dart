class Sale {
  final String orderId;
  final String customer;
  final DateTime date;
  final String product;
  final int quantity;
  final double amount;
  final String status;

  Sale(this.orderId, this.customer, this.date, this.product, this.quantity,
      this.amount, this.status);
}