import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/expenses_table/category_chip.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/expenses_table/expense_actions.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/text_styles.dart';
class ExpensesTable extends StatelessWidget {
  final List<Expense> expenses;
  final Color Function(String) colorBuilder;
  final void Function(Expense)? onEdit;
  final void Function(Expense)? onDelete;
  final void Function(Expense)? onReceipt;

  const ExpensesTable({
    required this.expenses,
    required this.colorBuilder,
    this.onEdit,
    this.onDelete,
    this.onReceipt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(const Color(0xFFF5F7F9)),
        columns: _columns,
        rows: expenses.map((e) => _row(e, context)).toList(),
      ),
    );
  }

  List<DataColumn> get _columns => const [
        DataColumn(label: Text('Date', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Amount', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Description', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Vendor', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Category', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Method', style: TextStyles.columnHeader)),
        DataColumn(label: Text('Actions', style: TextStyles.columnHeader)),
      ];

  DataRow _row(Expense e, BuildContext ctx) {
    return DataRow(cells: [
      DataCell(Text(DateFormat('yyyy-MM-dd').format(e.date),
          style: TextStyles.cell)),
      DataCell(Text('KSh ${e.amount.toStringAsFixed(0)}',
          style: TextStyles.cellBold)),
      DataCell(Text(e.description, style: TextStyles.cell)),
      DataCell(Text(e.vendor, style: TextStyles.cell)),
      DataCell(CategoryChip(category: e.category, color: colorBuilder(e.category))),
      DataCell(Text(e.paymentMethod, style: TextStyles.cell)),
      DataCell(ExpenseActions(e, onEdit: onEdit, onDelete: onDelete, onReceipt: onReceipt)),
    ]);
  }
}
