import 'package:flutter/material.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/icon_btn.dart';
class ExpenseActions extends StatelessWidget {
  final Expense expense;
  final void Function(Expense)? onEdit;
  final void Function(Expense)? onDelete;
  final void Function(Expense)? onReceipt;

  const ExpenseActions(this.expense,
      {this.onEdit, this.onDelete, this.onReceipt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBtn(Icons.edit, const Color(0xFF7F8C8D), () => onEdit?.call(expense)),
        IconBtn(Icons.delete_outline, const Color(0xFFE74C3C),
            () => onDelete?.call(expense)),
        IconBtn(Icons.receipt, const Color(0xFF3498DB),
            () => onReceipt?.call(expense)),
      ],
    );
  }
}