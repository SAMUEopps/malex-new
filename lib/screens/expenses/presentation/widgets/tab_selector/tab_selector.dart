import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/tab_selector/tab_button.dart';
class TabSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const TabSelector({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          TabButton(
            text: 'Expenses',
            icon: Icons.receipt,
            selected: selected == 0,
            onTap: () => onSelect(0),
          ),
          const SizedBox(width: 12),
          TabButton(
            text: 'Cash Deposits',
            icon: Icons.account_balance_wallet,
            selected: selected == 1,
            onTap: () => onSelect(1),
          ),
        ],
      ),
    );
  }
}