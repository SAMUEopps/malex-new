import 'package:malex_new/models/expense.dart';


class ExpenseModel extends Expense {
  ExpenseModel({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required super.vendor,
    required super.category,
    required super.paymentMethod,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['_id'] ?? json['id'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      description: json['description'],
      vendor: json['vendor'],
      category: json['category'],
      paymentMethod: json['paymentMethod'],
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
    };
  }
}