import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadsTab extends StatelessWidget {
  final List<Lead> leads;
  final Color Function(String) statusColorBuilder;
  final VoidCallback? onAddLead;

  const LeadsTab({
    Key? key,
    required this.leads,
    required this.statusColorBuilder,
    this.onAddLead,
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
              'Leads',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddLead ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Lead'),
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
          child: leads.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No leads yet')),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leads.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final l = leads[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            statusColorBuilder(l.status).withOpacity(0.1),
                        child: Icon(Icons.leaderboard,
                            color: statusColorBuilder(l.status)),
                      ),
                      title: Text(l.company),
                      subtitle: Text('${l.contactPerson} • ${l.status}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone,
                            color: Color(0xFF3498DB)),
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