import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';

class DepositManager {
  final List<CashDeposit> _deposits = [];

  List<CashDeposit> get deposits => _deposits;

  void add(CashDeposit d) => _deposits.add(d);
}