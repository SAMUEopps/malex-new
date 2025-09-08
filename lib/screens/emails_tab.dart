import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/email.dart';

class EmailsTab extends StatelessWidget {
  final List<Email> emails;
  final VoidCallback? onCompose;
  final void Function(Email)? onOpen;

  const EmailsTab({
    Key? key,
    required this.emails,
    this.onCompose,
    this.onOpen,
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
              'Emails',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onCompose ?? () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Compose'),
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
          child: emails.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No emails yet')),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: emails.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final e = emails[i];
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEBF5FB),
                        child: Icon(Icons.email, color: Color(0xFF3498DB)),
                      ),
                      title: Text(e.subject),
                      subtitle: Text(
                          'From: ${e.from} • ${DateFormat('MMM dd, yyyy – HH:mm').format(e.date)}'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Color(0xFF7F8C8D)),
                      onTap: () => onOpen?.call(e),
                    );
                  },
                ),
        ),
      ],
    );
  }
}