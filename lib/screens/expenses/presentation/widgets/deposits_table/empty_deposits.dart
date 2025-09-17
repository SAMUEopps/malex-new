import 'package:flutter/material.dart';
class EmptyDeposits extends StatelessWidget {
  const EmptyDeposits();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('No cash deposits yet',
                style: TextStyle(color: Colors.grey[500], fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Click "Deposit Cash" to add a new deposit',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}