import 'package:dartz/dartz.dart';
import 'package:malex_new/core/error/failures.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_remote_ds.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource _remote;

  ExpenseRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    try {
      final list = await _remote.getExpenses();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Expense>> addExpense(Expense expense) async {
    try {
      final model = ExpenseModel(
        id: '', // mongo will create _id
        amount: expense.amount,
        date: expense.date,
        description: expense.description,
        vendor: expense.vendor,
        category: expense.category,
        paymentMethod: expense.paymentMethod,
      );
      final created = await _remote.createExpense(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Expense>> updateExpense(Expense expense) async {
    try {
      final model = ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        date: expense.date,
        description: expense.description,
        vendor: expense.vendor,
        category: expense.category,
        paymentMethod: expense.paymentMethod,
      );
      final updated = await _remote.updateExpense(expense.id, model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await _remote.deleteExpense(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}