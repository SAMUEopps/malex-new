import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malex_new/app/app.dart';
import 'package:malex_new/widgets/common/dashboard_card_widget.dart';
import '../models/expense.dart';  

class DashboardTab extends StatelessWidget {
  final List<DashboardCard> cards;
  final List<Expense> expenses;
  final Color Function(String) categoryColorBuilder;

  const DashboardTab({
    Key? key,
    required this.cards,
    required this.expenses,
    required this.categoryColorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dashboard Cards
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: cards
                .map((card) => DashboardCardWidget(card: card))
                .toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Recent Expenses
        const Text(
          'Recent Expenses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        //Expanded(
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
              child: DataTable(
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFFF5F7F9)),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ],
                rows: expenses
                    .take(5)
                    .map(
                      (expense) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              DateFormat('yyyy-MM-dd').format(expense.date),
                              style:
                                  const TextStyle(color: Color(0xFF2C3E50)),
                            ),
                          ),
                          DataCell(
                            Text(
                              'KSh ${expense.amount.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              expense.description,
                              style:
                                  const TextStyle(color: Color(0xFF2C3E50)),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: categoryColorBuilder(expense.category)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                expense.category,
                                style: TextStyle(
                                  color:
                                      categoryColorBuilder(expense.category),
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
        //)
      ],
    );
  }
}