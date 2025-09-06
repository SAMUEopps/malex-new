import 'package:flutter/material.dart';
import 'package:malex_new/screens/time_qr/helpers/work_phases.dart';
import 'time_window_card.dart';

class TimeWindowsSection extends StatelessWidget {
  final ScrollController scrollController;

  const TimeWindowsSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_filled, color: Color(0xFF2C3E50), size: 24),
              const SizedBox(width: 10),
              const Text("Today's Valid Time Windows",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50))),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Only scans performed during these time windows will be accepted. '
            'Outside these periods, the QR code maintains the last valid event.',
            style: TextStyle(fontSize: 14, color: Color(0xFF5A6C7D), height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                  onPressed: () => _scroll(-200),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final phase in kWorkPhases) ...[
                        TimeWindowCard(
                          time: _formatPhase(phase),
                          label: '${phase.label} Window',
                          color: phase.color,
                          icon: phase.icon,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onPressed: () => _scroll(200),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scroll(double delta) {
    scrollController.animateTo(
      scrollController.offset + delta,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  String _formatPhase(WorkPhase phase) =>
      '${phase.start.formatAs24()} - ${phase.end.formatAs24()}';
}

extension on TimeOfDay {
  String formatAs24() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}