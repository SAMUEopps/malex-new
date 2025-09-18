// models/expense.dart
class Expense {
  final String id;
  final double amount;
  final DateTime date;
  final String description;
  final String vendor;
  final String category;
  final String paymentMethod;
  final String? notes;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
    required this.vendor,
    required this.category,
    required this.paymentMethod,
    this.notes,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'] ?? json['id'] ?? '',
      amount: json['amount'] is double ? json['amount'] : json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      description: json['description'] ?? '',
      vendor: json['vendor'] ?? '',
      category: json['category'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'Cash',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'vendor': vendor,
      'category': category,
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }
}