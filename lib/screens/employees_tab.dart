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
        // Header with Add Button
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
        
        // Employee List - Use a Container with fixed height instead of Flexible/Expanded
        Container(
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
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
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'No employees yet',
                      style: TextStyle(
                        color: Color(0xFF7F8C8D),
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return _buildEmployeeListItem(employee);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmployeeListItem(Employee employee) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(
          color: Color(0xFFECF0F1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEBF5FB),
          child: Icon(
            Icons.badge,
            color: const Color(0xFF3498DB),
            size: 20,
          ),
        ),
        title: Text(
          employee.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          '${employee.position} • ${employee.branch}',
          style: const TextStyle(
            color: Color(0xFF7F8C8D),
            fontSize: 13,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.phone, size: 20),
          color: const Color(0xFF3498DB),
          onPressed: () => _callEmployee(employee),
        ),
      ),
    );
  }

  void _callEmployee(Employee employee) {
    // Implement phone call functionality
    print('Calling ${employee.name} at ${employee.phone}');
  }
}