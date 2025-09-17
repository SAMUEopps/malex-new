/*import 'package:flutter/material.dart';
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
        
      ],
    );
  }

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
}*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/record.dart';

class RecordsTab extends StatefulWidget {
  final VoidCallback? onNewRecord;

  const RecordsTab({Key? key, this.onNewRecord}) : super(key: key);

  @override
  State<RecordsTab> createState() => _RecordsTabState();
}

class _RecordsTabState extends State<RecordsTab> {
  late Future<List<Record>> _recordsFuture;

  /*Future<List<Record>> _fetchRecords() async {
    final uri = Uri.parse('http://192.168.100.177:5000/api/records');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) throw Exception('Failed to load records');
    final List body = (recordsFromJson(resp.body));
    return body.map((e) => Record.fromJson(e)).toList();
  }*/


Future<List<Record>> _fetchRecords() async {
  final uri = Uri.parse('http://192.168.100.177:5000/api/records');
  print('Fetching records from $uri');

  final resp = await http.get(uri);
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');

  if (resp.statusCode != 200) {
    throw Exception('Failed to load records');
  }

  try {
    final List<dynamic> body = json.decode(resp.body);
    print('Decoded JSON length: ${body.length}');

    final records = body
        .map((e) {
          if (e is Map<String, dynamic>) {
            return Record.fromJson(e);
          } else {
            print('Unexpected record format: $e');
            return null;
          }
        })
        .where((e) => e != null)
        .cast<Record>()
        .toList();

    print('Parsed records count: ${records.length}');
    return records;
  } catch (e, stack) {
    print('Error parsing records: $e');
    print(stack);
    rethrow;
  }
}

  List<Record> recordsFromJson(String str) =>
      (List<Map<String, dynamic>>.from((str as List).map((x) => x)))
          .map((e) => Record.fromJson(e))
          .toList();

  @override
  void initState() {
    super.initState();
    _recordsFuture = _fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: widget.onNewRecord ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Record'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: Row(
            children: [
              _kpiCard('Total Records', '—', Colors.green[700]!),
              const SizedBox(width: 16),
              _kpiCard('Total Amount', '—', Colors.blue[700]!),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          child: FutureBuilder<List<Record>>(
            future: _recordsFuture,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(child: Text('Error: ${snap.error}'));
              }
              final records = snap.data!;
              return _buildTable(records);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTable(List<Record> records) {
    final dateFmt = DateFormat('yyyy-MM-dd');
    final timeFmt = DateFormat('HH:mm');

    return Container(
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
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF5F7F9)),
          columns: const [
            DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Type', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Doc No.', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Facilitator', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Created By', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
            DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)))),
          ],
          rows: records
              .map(
                (r) => DataRow(
                  cells: [
                    DataCell(Text(timeFmt.format(r.time))),
                    DataCell(Text(dateFmt.format(r.date))),
                    DataCell(Text(r.customerName)),
                    DataCell(Text(r.docType)),
                    DataCell(Text(r.docNo)),
                    DataCell(Text('KSh ${r.amount.toStringAsFixed(0)}')),
                    DataCell(Text(r.facilitator)),
                    DataCell(Text(r.createdBy)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          onPressed: () => _onEdit(r),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 18),
                          onPressed: () => _onDelete(r),
                        ),
                      ],
                    )),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _onEdit(Record r) {/* TODO: navigate to edit form */}

  void _onDelete(Record r) async {
    final uri = Uri.parse('http://192.168.100.177:5000/api/records/${r.id}');
    final resp = await http.delete(uri);
    if (resp.statusCode == 200) {
      setState(() => _recordsFuture = _fetchRecords());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete')),
      );
    }
  }

  Widget _kpiCard(String title, String value, Color color) {
    return Container(
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