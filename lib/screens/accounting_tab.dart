import 'package:flutter/material.dart';

class AccountingTab extends StatelessWidget {
  final VoidCallback? onViewPnL;
  final VoidCallback? onViewBalanceSheet;
  final VoidCallback? onViewTransactions;

  const AccountingTab({
    Key? key,
    this.onViewPnL,
    this.onViewBalanceSheet,
    this.onViewTransactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accounting Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),

        // KPI cards
        SizedBox(
          height: 100,
          child: Row(
            children: [
              _kpiCard('Total Revenue', 'KSh 245,800', Colors.green[700]!),
              const SizedBox(width: 16),
              _kpiCard('Total Expenses', 'KSh 142,300', Colors.red[700]!),
              const SizedBox(width: 16),
              _kpiCard('Net Profit', 'KSh 103,500', Colors.blue[700]!),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Charts row
        Row(
          children: [
            Expanded(
              child: _chartCard(
                'Profit & Loss Statement',
                Icons.bar_chart,
                onViewPnL,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _chartCard(
                'Balance Sheet',
                Icons.pie_chart,
                onViewBalanceSheet,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Recent Transactions
        Expanded(
          child: _chartCard(
            'Recent Transactions',
            Icons.receipt_long,
            onViewTransactions,
            expanded: true,
          ),
        ),
      ],
    );
  }

  Widget _kpiCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 14)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _chartCard(String title, IconData icon, VoidCallback? onTap, {bool expanded = false}) {
    return Container(
      height: expanded ? double.infinity : 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50))),
          const SizedBox(height: 16),
          Expanded(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: Icon(icon, size: 48, color: const Color(0xFFBDC3C7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}