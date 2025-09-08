import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomersTab extends StatelessWidget {
  final List<Customer> customers;
  final VoidCallback? onAddCustomer;

  const CustomersTab({
    Key? key,
    required this.customers,
    this.onAddCustomer,
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
              'Customers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddCustomer ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Customer'),
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
          child: customers.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No customers yet')),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: customers.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final c = customers[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFEBF5FB),
                        child: const Icon(Icons.people, color: Color(0xFF3498DB)),
                      ),
                      title: Text(c.name),
                      subtitle: Text(c.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.email, color: Color(0xFF3498DB)),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}