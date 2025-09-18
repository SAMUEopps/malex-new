// data/repositories/deposit_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:malex_new/core/error/failures.dart';
import 'package:malex_new/screens/expenses/data/datasources/deposit_remote_ds.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'package:malex_new/screens/expenses/domain/repositories/deposit_repository.dart';

class DepositRepositoryImpl implements DepositRepository {
  final DepositRemoteDataSource _remote;

  DepositRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<CashDeposit>>> getDeposits() async {
    try {
      final list = await _remote.getDeposits();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CashDeposit>> addDeposit(CashDeposit deposit) async {
    try {
      final created = await _remote.createDeposit(deposit);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CashDeposit>> updateDeposit(CashDeposit deposit) async {
    try {
      final updated = await _remote.updateDeposit(deposit.id, deposit);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteDeposit(String id) async {
    try {
      await _remote.deleteDeposit(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}