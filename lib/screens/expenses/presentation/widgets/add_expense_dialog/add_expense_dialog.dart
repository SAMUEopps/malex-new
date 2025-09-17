import 'package:flutter/material.dart';
import 'package:malex_new/models/expense.dart';
import 'expense_dialog_content.dart';

class AddExpenseDialog {
  static Future<Expense?> show(BuildContext context) async {
    return await showDialog<Expense>(
      context: context,
      builder: (_) => const ExpenseDialogContent(),
    );
  }
}