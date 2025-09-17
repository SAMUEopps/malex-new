
import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/button_styles.dart';
class AddDepositButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddDepositButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.account_balance_wallet, size: 16),
      label: const Text('Deposit Cash'),
      style: ButtonStyles.success,
    );
  }
}