
import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_expense_dialog/add_expense_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/button_styles.dart';
class AddExpenseButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AddExpenseButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap ?? () async {
      final expense = await AddExpenseDialog.show(context);
      if (expense == null) return;
      // forward to parent callback
      // (you can expose onAddExpense(Expense) from ExpensesTab if you wish)
    },
      icon: const Icon(Icons.add, size: 16),
      label: const Text('Add Expense'),
      style: ButtonStyles.primary,
    );
  }
}