import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCard extends StatelessWidget {
  final String qrData;
  final String eventLabel;
  final String formattedTime;
  final Color eventColor;

  const QrCard({
    super.key,
    required this.qrData,
    required this.eventLabel,
    required this.formattedTime,
    required this.eventColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: eventColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Current Event: $eventLabel',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Scan this QR code to record time for the current event',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7F8C8D))),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDCE0E3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 8),
                Text('Updated: $formattedTime',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF7F8C8D))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}