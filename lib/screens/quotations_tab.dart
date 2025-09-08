import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/quotation.dart';

class QuotationsTab extends StatelessWidget {
  final List<Quotation> quotations;
  final Color Function(String) statusColorBuilder;
  final VoidCallback? onCreate;

  const QuotationsTab({
    Key? key,
    required this.quotations,
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
              'Quotations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onCreate ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create Quotation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
         Container(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFFF5F7F9)),
                columns: const [
                  DataColumn(label: Text('Quotation #', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                ],
                rows: quotations
                    .map(
                      (q) => DataRow(
                        cells: [
                          DataCell(Text(q.quotationNumber, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(q.customer, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(q.date), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text('KSh ${q.amount.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColorBuilder(q.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                q.status,
                                style: TextStyle(
                                  color: statusColorBuilder(q.status),
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
        
      ],
    );
  }
}