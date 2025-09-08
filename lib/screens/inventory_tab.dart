import 'package:flutter/material.dart';
import 'package:malex_new/models/inventory.dart';

class InventoryTab extends StatelessWidget {
  final List<InventoryItem> items;
  final VoidCallback? onAddItem;

  const InventoryTab({
    Key? key,
    required this.items,
    this.onAddItem,
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
              'Inventory Management',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddItem ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Item'),
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
              _kpiCard('Total Items', '6', Colors.blue[700]!),
              const SizedBox(width: 16),
              _kpiCard('Low Stock Items', _lowStockCount().toString(), Colors.orange[700]!),
              const SizedBox(width: 16),
              _kpiCard('Inventory Value', 'KSh 245,800', Colors.green[700]!),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // DataTable
        Container(
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
                  DataColumn(label: Text('Product Name', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('SKU', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Stock Level', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Unit', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Location', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
                ],
                rows: items
                    .map(
                      (item) => DataRow(
                        cells: [
                          DataCell(Text(item.name, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(item.sku, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(item.category, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(
                            Text(
                              item.stockLevel.toString(),
                              style: TextStyle(
                                color: item.stockLevel <= item.lowStockThreshold
                                    ? const Color(0xFFE74C3C)
                                    : const Color(0xFF2C3E50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          DataCell(Text(item.unit, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(Text(item.location, style: const TextStyle(color: Color(0xFF2C3E50)))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.stockLevel <= item.lowStockThreshold
                                    ? const Color(0xFFFFF0F0)
                                    : const Color(0xFFF0FFF4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.stockLevel <= item.lowStockThreshold ? 'Low Stock' : 'In Stock',
                                style: TextStyle(
                                  color: item.stockLevel <= item.lowStockThreshold
                                      ? const Color(0xFFE74C3C)
                                      : const Color(0xFF2ECC71),
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

  int _lowStockCount() => items.where((i) => i.stockLevel <= i.lowStockThreshold).length;

  Widget _kpiCard(String title, String value, Color color) {
    return  Container(
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
      
    );
  }
}