import 'package:flutter/material.dart';

class RecentRecordsStub extends StatelessWidget {
  const RecentRecordsStub({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Time records will appear here after QR scans',
            style: TextStyle(color: Color(0xFF7F8C8D)),
          ),
        ),
      ),
    );
  }
}