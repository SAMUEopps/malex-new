/*class CashDeposit {
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
}*/

// data/models/cash_deposit.dart
// data/models/cash_deposit.dart
class CashDeposit {
  final String id;
  final String source;
  final double amount;
  final DateTime date;
  final String? notes;

  CashDeposit({
    required this.id,
    required this.source,
    required this.amount,
    required this.date,
    this.notes,
  });

  factory CashDeposit.fromJson(Map<String, dynamic> json) {
    return CashDeposit(
      id: json['_id'] ?? json['id'] ?? '',
      source: json['source'] ?? '',
      amount: json['amount'] is double ? json['amount'] : json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'amount': amount,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}