class Invoice {
  final String invoiceNumber;
  final String customer;
  final DateTime issueDate;
  final DateTime dueDate;
  final double amount;
  final String status;

  Invoice(this.invoiceNumber, this.customer, this.issueDate, this.dueDate,
      this.amount, this.status);
}