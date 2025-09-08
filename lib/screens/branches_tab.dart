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
          child: branches.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No branches yet')),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: branches.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
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
      ],
    );
  }
}