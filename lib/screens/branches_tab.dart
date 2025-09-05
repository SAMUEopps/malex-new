import 'package:flutter/material.dart';
import '../models/branch.dart';

class BranchesTab extends StatelessWidget {
  final List<Branch> branches;
  final VoidCallback? onAddBranch;

  const BranchesTab({
    Key? key,
    required this.branches,
    this.onAddBranch,
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
              'Branches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddBranch ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Branch'),
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
            child: branches.isEmpty
                ? const Center(child: Text('No branches yet'))
                : ListView.builder(
                    itemCount: branches.length,
                    itemBuilder: (_, i) {
                      final b = branches[i];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEBF5FB),
                          child: Icon(Icons.business, color: Color(0xFF3498DB)),
                        ),
                        title: Text(b.name),
                        subtitle: Text('${b.manager} • ${b.address}'),
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