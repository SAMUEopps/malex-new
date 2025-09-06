import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malex_new/screens/time_qr/helpers/qr_data_generator.dart';
import 'package:malex_new/screens/time_qr/helpers/work_phases.dart';
import 'time_windows_section.dart';
import 'qr_card.dart';
import 'recent_records_stub.dart';

class TimeQrBody extends StatelessWidget {
  final ScrollController scrollController;
  final String currentEvent;
  final String desktopId;
  final DateTime lastUpdate;

  const TimeQrBody({
    super.key,
    required this.scrollController,
    required this.currentEvent,
    required this.desktopId,
    required this.lastUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final phase = kWorkPhases.firstWhere((p) => p.key == currentEvent);
    final qrData = generateQrData(event: currentEvent, desktopId: desktopId);
    final formattedTime = DateFormat("HH:mm").format(lastUpdate);

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
        TimeWindowsSection(scrollController: scrollController),
        const SizedBox(height: 24),
        QrCard(
          qrData: qrData,
          eventLabel: phase.label,
          formattedTime: formattedTime,
          eventColor: phase.color,
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
        const RecentRecordsStub(),
      ],
    );
  }
}