// expenses_tab.dart
import 'package:flutter/material.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/data/helpers/deposit_manager.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_deposit_dialog/add_deposit_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/deposits_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/expenses_table/expenses_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_deposit_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_expense_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/header.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/tab_selector/tab_selector.dart';



/* -------------------------------------------------------------------------- */
/*                                Public API                                  */
/* -------------------------------------------------------------------------- */

class ExpensesTab extends StatefulWidget {
  final List<Expense> expenses;
  final Color Function(String) categoryColorBuilder;
  final VoidCallback? onAdd;
  final VoidCallback? onFilter;
  final void Function(Expense)? onEdit;
  final void Function(Expense)? onDelete;
  final void Function(Expense)? onReceipt;
  final void Function(CashDeposit)? onDeposit;

  const ExpensesTab({
    Key? key,
    required this.expenses,
    required this.categoryColorBuilder,
    this.onAdd,
    this.onFilter,
    this.onEdit,
    this.onDelete,
    this.onReceipt,
    this.onDeposit,
  }) : super(key: key);

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

/* -------------------------------------------------------------------------- */
/*                              State & Logic                                 */
/* -------------------------------------------------------------------------- */

class _ExpensesTabState extends State<ExpensesTab> {
  final _depositManager = DepositManager();
  var _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: 'Expense Financial Records',
              onFilter: widget.onFilter,
              actionButton: _selectedTab == 0
                  ? AddExpenseButton(onTap: widget.onAdd)
                  : AddDepositButton(
                      onTap: () => _showDepositDialog(context)),
            ),
            const SizedBox(height: 16),
            TabSelector(
              selected: _selectedTab,
              onSelect: (i) => setState(() => _selectedTab = i),
            ),
            const SizedBox(height: 16),
            _selectedTab == 0
                ? ExpensesTable(
                    expenses: widget.expenses,
                    colorBuilder: widget.categoryColorBuilder,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                    onReceipt: widget.onReceipt,
                  )
                : DepositsTable(deposits: _depositManager.deposits),
          ],
        ),
      ),
    );
  }

  void _showDepositDialog(BuildContext ctx) async {
    final deposit = await AddDepositDialog.show(ctx);
    if (deposit == null) return;
    _depositManager.add(deposit);
    widget.onDeposit?.call(deposit);
    setState(() {});
  }
}