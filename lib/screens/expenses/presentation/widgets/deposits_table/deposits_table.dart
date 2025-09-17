import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/deposit_actions.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/empty_deposits.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/source_chip.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/text_styles.dart';

class DepositsTable extends StatelessWidget {
  final List<CashDeposit> deposits;

  const DepositsTable({required this.deposits});

  @override
  Widget build(BuildContext context) {
    if (deposits.isEmpty) return const EmptyDeposits();
    return Card(
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(const Color(0xFFF5F7F9)),
        columns: const [
          DataColumn(label: Text('Date', style: TextStyles.columnHeader)),
          DataColumn(label: Text('Amount', style: TextStyles.columnHeader)),
          DataColumn(label: Text('Source', style: TextStyles.columnHeader)),
          DataColumn(label: Text('Notes', style: TextStyles.columnHeader)),
          DataColumn(label: Text('Actions', style: TextStyles.columnHeader)),
        ],
        rows: deposits.map((d) => _depositRow(d)).toList(),
      ),
    );
  }

  DataRow _depositRow(CashDeposit d) {
    return DataRow(cells: [
      DataCell(Text(DateFormat('yyyy-MM-dd – HH:mm').format(d.date),
          style: TextStyles.cell)),
      DataCell(Text('KSh ${d.amount.toStringAsFixed(0)}',
          style: TextStyles.cellBold)),
      DataCell(SourceChip(source: d.source)),
      DataCell(Text(d.notes ?? 'No notes',
          style: TextStyle(
              color: const Color(0xFF2C3E50),
              fontStyle: d.notes == null ? FontStyle.italic : FontStyle.normal))),
      DataCell(DepositActions(d)),
    ]);
  }
}