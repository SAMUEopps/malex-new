import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/icon_btn.dart';

class DepositActions extends StatelessWidget {
  final CashDeposit deposit;

  const DepositActions(this.deposit);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBtn(Icons.edit, const Color(0xFF7F8C8D), () {}),
        IconBtn(Icons.delete_outline, const Color(0xFFE74C3C), () {}),
      ],
    );
  }
}