import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cash_sale.dart';

class CashSalesTab extends StatelessWidget {
  final List<CashSale> sales;
  final VoidCallback? onNewSale;

  const CashSalesTab({
    Key? key,
    required this.sales,
    this.onNewSale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cash Sales',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onNewSale ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Cash Sale'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: sales.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No cash-sales yet')),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sales.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final s = sales[i];
                    return ListTile(
                      leading: const Icon(Icons.point_of_sale,
                          color: Color(0xFF3498DB)),
                      title: Text(s.description),
                      subtitle: Text(
                          '${s.quantity} units • ${DateFormat('yyyy-MM-dd').format(s.date)}'),
                      trailing: Text(
                        'KSh ${s.amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}