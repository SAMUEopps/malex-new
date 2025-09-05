import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/sale.dart';

class SalesTab extends StatelessWidget {
  final List<Sale> sales;
  final Color Function(String) statusColorBuilder;
  final VoidCallback? onNewSale;

  const SalesTab({
    Key? key,
    required this.sales,
    required this.statusColorBuilder,
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
              'Sales Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onNewSale ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Sale'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // KPI cards
        SizedBox(
          height: 100,
          child: Row(
            children: [
              _kpiCard('Total Revenue', 'KSh 49,900', Colors.green[700]!),
              const SizedBox(width: 16),
              _kpiCard('Orders', '5', Colors.blue[700]!),
              const SizedBox(width: 16),
              _kpiCard('Avg. Order Value', 'KSh 9,980', Colors.orange[700]!),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // DataTable
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFFF5F7F9)),
                columns: const [
                  DataColumn(label: Text('Order ID', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Product', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Quantity', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                ],
                rows: sales
                    .map(
                      (s) => DataRow(
                        cells: [
                          DataCell(Text(s.orderId, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(s.customer, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(s.date), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(s.product, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(s.quantity.toString(), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text('KSh ${s.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColorBuilder(s.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s.status,
                                style: TextStyle(
                                  color: statusColorBuilder(s.status),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
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
}