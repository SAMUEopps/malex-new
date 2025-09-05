import 'package:flutter/material.dart';

class TimeQrTab extends StatelessWidget {
  final VoidCallback? onDownloadQr;
  final VoidCallback? onShareQr;

  const TimeQrTab({
    Key? key,
    this.onDownloadQr,
    this.onShareQr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Tracking QR Code',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),

        // QR Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Scan this QR code to record time for activities',
                style: TextStyle(color: Color(0xFF7F8C8D)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDCE0E3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.qr_code, size: 200, color: Color(0xFF2C3E50)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Company Time Tracking QR',
                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Scan with your company app to record time in/out',
                style: TextStyle(color: Color(0xFF7F8C8D)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: onDownloadQr ?? () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Download QR'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3498DB),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: onShareQr ?? () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2C3E50),
                      side: const BorderSide(color: Color(0xFFDCE0E3)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Recent Time Records',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
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
          ),
        ),
      ],
    );
  }
}