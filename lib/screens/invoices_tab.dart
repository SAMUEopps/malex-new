import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/invoice.dart';

class InvoicesTab extends StatelessWidget {
  final List<Invoice> invoices;
  final Color Function(String) statusColorBuilder;
  final VoidCallback? onCreate;

  const InvoicesTab({
    Key? key,
    required this.invoices,
    required this.statusColorBuilder,
    this.onCreate,
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
              'Invoice Management',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onCreate ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create Invoice'),
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
              _kpiCard('Total Invoiced', 'KSh 49,900', Colors.green[700]!),
              const SizedBox(width: 16),
              _kpiCard('Outstanding', 'KSh 10,900', Colors.orange[700]!),
              const SizedBox(width: 16),
              _kpiCard('Overdue', 'KSh 4,200', Colors.red[700]!),
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
                  DataColumn(label: Text('Invoice #', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Issue Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Due Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                ],
                rows: invoices
                    .map(
                      (inv) => DataRow(
                        cells: [
                          DataCell(Text(inv.invoiceNumber, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(inv.customer, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(inv.issueDate), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(inv.dueDate), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text('KSh ${inv.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColorBuilder(inv.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                inv.status,
                                style: TextStyle(
                                  color: statusColorBuilder(inv.status),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.visibility, size: 18, color: Color(0xFF7F8C8D)), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.email, size: 18, color: Color(0xFF3498DB)), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.download, size: 18, color: Color(0xFF2ECC71)), onPressed: () {}),
                              ],
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