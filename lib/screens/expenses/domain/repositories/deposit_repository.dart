// domain/repositories/deposit_repository.dart
import 'package:dartz/dartz.dart';
import 'package:malex_new/core/error/failures.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';

abstract class DepositRepository {
  Future<Either<Failure, List<CashDeposit>>> getDeposits();
  Future<Either<Failure, CashDeposit>> addDeposit(CashDeposit deposit);
  Future<Either<Failure, CashDeposit>> updateDeposit(CashDeposit deposit);
  Future<Either<Failure, void>> deleteDeposit(String id);
}