import 'package:intl/intl.dart';

String generateQrData({
  required String event,
  required String desktopId,
}) {
  final timestamp = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now());
  return '{"event":"$event","desktop_id":"$desktopId","timestamp":"$timestamp"}';
}