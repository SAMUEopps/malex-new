class Record {
  final String id;
  final DateTime date;
  final DateTime time;
  final String customerName;
  final String? invoiceNo;
  final String? cashSaleNo;
  final String? quotationNo;
  final String facilitator;
  final double amount;
  final String createdBy;

  Record({
    required this.id,
    required this.date,
    required this.time,
    required this.customerName,
    this.invoiceNo,
    this.cashSaleNo,
    this.quotationNo,
    required this.facilitator,
    required this.amount,
    required this.createdBy,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      customerName: json['customerName'],
      invoiceNo: json['invoiceNo'],
      cashSaleNo: json['cashSaleNo'],
      quotationNo: json['quotationNo'],
      facilitator: json['facilitator'],
      amount: (json['amount'] as num).toDouble(),
      createdBy: json['createdBy'],
    );
  }

  String get docType {
    if (invoiceNo != null) return 'Invoice';
    if (cashSaleNo != null) return 'Cash Sale';
    if (quotationNo != null) return 'Quotation';
    return 'N/A';
  }

  String get docNo {
    return invoiceNo ?? cashSaleNo ?? quotationNo ?? 'N/A';
  }
}