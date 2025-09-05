import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpensesTab extends StatelessWidget {
  final List<Expense> expenses;
  final Color Function(String) categoryColorBuilder;
  final VoidCallback? onAdd;
  final VoidCallback? onFilter;
  final void Function(Expense)? onEdit;
  final void Function(Expense)? onDelete;
  final void Function(Expense)? onReceipt;

  const ExpensesTab({
    Key? key,
    required this.expenses,
    required this.categoryColorBuilder,
    this.onAdd,
    this.onFilter,
    this.onEdit,
    this.onDelete,
    this.onReceipt,
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
              'Expense Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: onFilter ?? () {},
                  icon: const Icon(Icons.filter_list, size: 16),
                  label: const Text('Filter'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2C3E50),
                    side: const BorderSide(color: Color(0xFFDCE0E3)),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: onAdd ?? () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Expense'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
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
                  DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Description', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Vendor', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                ],
                rows: expenses
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(e.date), style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text('KSh ${e.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                          DataCell(Text(e.description, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(e.vendor, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: categoryColorBuilder(e.category).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(e.category, style: TextStyle(color: categoryColorBuilder(e.category), fontWeight: FontWeight.w500, fontSize: 12)),
                            ),
                          ),
                          DataCell(Text(e.paymentMethod, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.edit, size: 18, color: Color(0xFF7F8C8D)), onPressed: () => onEdit?.call(e)),
                                IconButton(icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFFE74C3C)), onPressed: () => onDelete?.call(e)),
                                IconButton(icon: const Icon(Icons.receipt, size: 18, color: Color(0xFF3498DB)), onPressed: () => onReceipt?.call(e)),
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
}