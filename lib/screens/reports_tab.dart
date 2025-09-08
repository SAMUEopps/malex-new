import 'package:flutter/material.dart';

class ReportsTab extends StatelessWidget {
  final VoidCallback? onExpenseReport;
  final VoidCallback? onSalesReport;
  final VoidCallback? onProfitabilityReport;
  final VoidCallback? onTaxReport;
  final VoidCallback? onInventoryReport;
  final VoidCallback? onCustomBuilder;

  const ReportsTab({
    Key? key,
    this.onExpenseReport,
    this.onSalesReport,
    this.onProfitabilityReport,
    this.onTaxReport,
    this.onInventoryReport,
    this.onCustomBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Financial Reports',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),

        // Report cards
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _reportCard(
                title: 'Expense Report',
                description: 'Spending by category and supplier',
                icon: Icons.receipt,
                color: const Color(0xFF3498DB),
                onTap: onExpenseReport,
              ),
              _reportCard(
                title: 'Sales Report',
                description: 'Revenue trends and product performance',
                icon: Icons.trending_up,
                color: const Color(0xFF2ECC71),
                onTap: onSalesReport,
              ),
              _reportCard(
                title: 'Profitability Report',
                description: 'Product and customer profitability',
                icon: Icons.attach_money,
                color: const Color(0xFFE67E22),
                onTap: onProfitabilityReport,
              ),
              _reportCard(
                title: 'Tax Report',
                description: 'Taxable sales and deductible expenses',
                icon: Icons.description,
                color: const Color(0xFF9B59B6),
                onTap: onTaxReport,
              ),
              _reportCard(
                title: 'Inventory Report',
                description: 'Stock levels and valuation',
                icon: Icons.inventory,
                color: const Color(0xFFE74C3C),
                onTap: onInventoryReport,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Charts row - Use fixed height containers instead of Expanded
        Row(
          children: [
            Expanded(
              child: Container(
                height: 300,
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
                    const Text('Expense by Category', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50))),
                    const SizedBox(height: 16),
                    Expanded(
                      child: InkWell(
                        onTap: onExpenseReport,
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(child: Icon(Icons.pie_chart, size: 48, color: Color(0xFFBDC3C7))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 300,
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
                    const Text('Sales Trends', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50))),
                    const SizedBox(height: 16),
                    Expanded(
                      child: InkWell(
                        onTap: onSalesReport,
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(child: Icon(Icons.show_chart, size: 48, color: Color(0xFFBDC3C7))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Custom Report Builder - Use fixed height instead of Expanded
        Container(
          height: 300, // Fixed height instead of Expanded
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
              const Text('Custom Report Builder', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50))),
              const SizedBox(height: 16),
              Expanded(
                child: InkWell(
                  onTap: onCustomBuilder,
                  borderRadius: BorderRadius.circular(8),
                  child: const Center(child: Icon(Icons.analytics, size: 48, color: Color(0xFFBDC3C7))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reportCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(right: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}