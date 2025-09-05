import '../../models/invoice.dart';

final List<Invoice> seedInvoices = [
  Invoice('INV-2024-001', 'Nairobi Chemicals', DateTime(2024, 4, 25), DateTime(2024, 5, 25), 12000.0, 'Paid'),
  Invoice('INV-2024-002', 'Mombasa Pharma', DateTime(2024, 4, 24), DateTime(2024, 5, 24), 8500.0, 'Paid'),
  Invoice('INV-2024-003', 'Kisumu Labs', DateTime(2024, 4, 23), DateTime(2024, 5, 23), 6700.0, 'Unpaid'),
  Invoice('INV-2024-004', 'Eldoret Manufacturing', DateTime(2024, 4, 22), DateTime(2024, 5, 22), 18500.0, 'Paid'),
  Invoice('INV-2024-005', 'Nakuru Research', DateTime(2024, 4, 20), DateTime(2024, 5, 20), 4200.0, 'Overdue'),
];