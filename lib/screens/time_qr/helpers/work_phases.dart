import 'package:flutter/material.dart';

class WorkPhase {
  final String key;
  final TimeOfDay start;
  final TimeOfDay end;
  final String label;
  final Color color;
  final IconData icon;

  const WorkPhase({
    required this.key,
    required this.start,
    required this.end,
    required this.label,
    required this.color,
    required this.icon,
  });
}

/// Immutable list of company work-phases.
const kWorkPhases = [
  WorkPhase(
    key: 'time_in',
    start: TimeOfDay(hour: 7, minute: 0),
    end: TimeOfDay(hour: 9, minute: 0),
    label: 'Time In',
    color: Color(0xFF2ECC71),
    icon: Icons.login,
  ),
  WorkPhase(
    key: 'lunch_out',
    start: TimeOfDay(hour: 12, minute: 0),
    end: TimeOfDay(hour: 13, minute: 0),
    label: 'Lunch Out',
    color: Color(0xFFE67E22),
    icon: Icons.lunch_dining,
  ),
  WorkPhase(
    key: 'lunch_in',
    start: TimeOfDay(hour: 13, minute: 0),
    end: TimeOfDay(hour: 14, minute: 0),
    label: 'Lunch In',
    color: Color(0xFF3498DB),
    icon: Icons.dining,
  ),
  WorkPhase(
    key: 'departure',
    start: TimeOfDay(hour: 16, minute: 0),
    end: TimeOfDay(hour: 18, minute: 0),
    label: 'Departure',
    color: Color(0xFFE74C3C),
    icon: Icons.logout,
  ),
];