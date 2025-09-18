// expenses_tab.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/data/helpers/deposit_manager.dart';
import 'package:malex_new/screens/expenses/presentation/providers/expense_provider.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_deposit_dialog/add_deposit_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_expense_dialog/add_expense_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/deposits_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/expenses_table/expenses_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_deposit_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_expense_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/header.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/tab_selector/tab_selector.dart';

class ExpensesTab extends ConsumerStatefulWidget {
  final Color Function(String) categoryColorBuilder;

  const ExpensesTab({
    Key? key,
    required this.categoryColorBuilder,
  }) : super(key: key);

  @override
  ConsumerState<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends ConsumerState<ExpensesTab> {
  final _depositManager = DepositManager();
  var _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Fetch expenses when the tab is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseNotifierProvider.notifier).fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseNotifierProvider);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: 'Expense Financial Records',
              onFilter: _onFilter,
              actionButton: _selectedTab == 0
                  ? AddExpenseButton(onTap: _onAddExpense)
                  : AddDepositButton(onTap: () => _showDepositDialog(context)),
            ),
            const SizedBox(height: 16),
            TabSelector(
              selected: _selectedTab,
              onSelect: (i) => setState(() => _selectedTab = i),
            ),
            const SizedBox(height: 16),
            if (expenseState.loading) 
              const Center(child: CircularProgressIndicator()),
            if (expenseState.error != null)
              Text('Error: ${expenseState.error}', style: TextStyle(color: Colors.red)),
            if (!expenseState.loading && expenseState.error == null)
              _selectedTab == 0
                  ? ExpensesTable(
                      expenses: expenseState.expenses,
                      colorBuilder: widget.categoryColorBuilder,
                      onEdit: _onEditExpense,
                      onDelete: _onDeleteExpense,
                      onReceipt: _onReceipt,
                    )
                  : DepositsTable(deposits: _depositManager.deposits),
          ],
        ),
      ),
    );
  }

  void _onAddExpense() async {
    final expense = await AddExpenseDialog.show(context);
    if (expense == null) return;
    ref.read(expenseNotifierProvider.notifier).addExpense(expense);
  }

  void _onEditExpense(Expense expense) async {
    // Implement edit dialog similar to add dialog
    final updatedExpense = await _showEditExpenseDialog(context, expense);
    if (updatedExpense != null) {
      ref.read(expenseNotifierProvider.notifier).updateExpense(updatedExpense);
    }
  }

  void _onDeleteExpense(Expense expense) {
    ref.read(expenseNotifierProvider.notifier).deleteExpense(expense.id);
  }

  void _onFilter() {
    // Implement filter functionality
  }

  void _onReceipt(Expense expense) {
    // Implement receipt functionality
  }

  void _showDepositDialog(BuildContext ctx) async {
    final deposit = await AddDepositDialog.show(ctx);
    if (deposit == null) return;
    _depositManager.add(deposit);
    setState(() {});
  }

  Future<Expense?> _showEditExpenseDialog(BuildContext context, Expense expense) async {
    // Similar to AddExpenseDialog but pre-filled with expense data
    // You'll need to create an EditExpenseDialog
    return null;
  }
}*/

// expenses_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/presentation/providers/deposit_notifire.dart';
import 'package:malex_new/screens/expenses/presentation/providers/expense_provider.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_deposit_dialog/add_deposit_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_expense_dialog/add_expense_dialog.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/deposits_table/deposits_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/expenses_table/expenses_table.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_deposit_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/add_expense_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/header.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/tab_selector/tab_selector.dart';

class ExpensesTab extends ConsumerStatefulWidget {
  final Color Function(String) categoryColorBuilder;

  const ExpensesTab({
    Key? key,
    required this.categoryColorBuilder,
  }) : super(key: key);

  @override
  ConsumerState<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends ConsumerState<ExpensesTab> {
  var _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Fetch both lists once the frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseNotifierProvider.notifier).fetchExpenses();
      ref.read(depositNotifierProvider.notifier).fetchDeposits();
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseNotifierProvider);
    final depositState = ref.watch(depositNotifierProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: 'Expense Financial Records',
              onFilter: _onFilter,
              actionButton: _selectedTab == 0
                  ? AddExpenseButton(onTap: _onAddExpense)
                  : AddDepositButton(onTap: () => _showDepositDialog(context)),
            ),
            const SizedBox(height: 16),
            TabSelector(
              selected: _selectedTab,
              onSelect: (i) => setState(() => _selectedTab = i),
            ),
            const SizedBox(height: 16),

            /* ----------  EXPENSE TAB  ---------- */
            if (_selectedTab == 0) ...[
              if (expenseState.loading)
                const Center(child: CircularProgressIndicator()),
              if (expenseState.error != null)
                Text('Error: ${expenseState.error}',
                    style: const TextStyle(color: Colors.red)),
              if (!expenseState.loading && expenseState.error == null)
                ExpensesTable(
                  expenses: expenseState.expenses,
                  colorBuilder: widget.categoryColorBuilder,
                  //onEdit: _onEditExpense,
                  onDelete: _onDeleteExpense,
                  onReceipt: _onReceipt,
                ),
            ],

            /* ----------  DEPOSIT TAB  ---------- */
            if (_selectedTab == 1) ...[
              if (depositState.loading)
                const Center(child: CircularProgressIndicator()),
              if (depositState.error != null)
                Text('Error: ${depositState.error}',
                    style: const TextStyle(color: Colors.red)),
              if (!depositState.loading && depositState.error == null)
                DepositsTable(deposits: depositState.deposits),
            ],
          ],
        ),
      ),
    );
  }

  /* -------------------------------------------------
                 EVENT HANDLERS
   ------------------------------------------------- */

  void _onAddExpense() async {
    final expense = await AddExpenseDialog.show(context);
    if (expense == null) return;
    ref.read(expenseNotifierProvider.notifier).addExpense(expense);
  }

  /*void _onEditExpense(Expense expense) async {
    final updated = await AddExpenseDialog.show(context, expense: expense);
    if (updated != null) {
      ref.read(expenseNotifierProvider.notifier).updateExpense(updated);
    }
  }*/

  void _onDeleteExpense(Expense expense) {
    ref.read(expenseNotifierProvider.notifier).deleteExpense(expense.id);
  }

  void _onFilter() {
    // TODO: implement filter
  }

  void _onReceipt(Expense expense) {
    // TODO: implement receipt
  }

  void _showDepositDialog(BuildContext ctx) async {
    final deposit = await AddDepositDialog.show(ctx);
    if (deposit == null) return;
    ref.read(depositNotifierProvider.notifier).addDeposit(deposit);
  }
}