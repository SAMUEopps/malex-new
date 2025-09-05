import '../../models/sale.dart';

final List<Sale> seedSales = [
  Sale('ORD-001', 'Nairobi Chemicals', DateTime(2024, 4, 25), 'Chloroform', 50, 12000.0, 'Delivered'),
  Sale('ORD-002', 'Mombasa Pharma', DateTime(2024, 4, 24), 'Acetone', 100, 8500.0, 'Delivered'),
  Sale('ORD-003', 'Kisumu Labs', DateTime(2024, 4, 23), 'Ethanol', 75, 6700.0, 'Processing'),
  Sale('ORD-004', 'Eldoret Manufacturing', DateTime(2024, 4, 22), 'Methanol', 200, 18500.0, 'Delivered'),
  Sale('ORD-005', 'Nakuru Research', DateTime(2024, 4, 20), 'Hydrogen Peroxide', 30, 4200.0, 'Pending'),
];