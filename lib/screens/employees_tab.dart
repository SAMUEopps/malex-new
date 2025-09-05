import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeesTab extends StatelessWidget {
  final List<Employee> employees;
  final VoidCallback? onAddEmployee;

  const EmployeesTab({
    Key? key,
    required this.employees,
    this.onAddEmployee,
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
              'Employees',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddEmployee ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Employee'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
              ),
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
            child: employees.isEmpty
                ? const Center(child: Text('No employees yet'))
                : ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (_, i) {
                      final e = employees[i];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEBF5FB),
                          child: Icon(Icons.badge, color: Color(0xFF3498DB)),
                        ),
                        title: Text(e.name),
                        subtitle: Text('${e.position} • ${e.branch}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.phone, color: Color(0xFF3498DB)),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}