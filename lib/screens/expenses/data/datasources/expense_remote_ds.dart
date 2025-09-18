/*import 'package:dio/dio.dart';
import 'package:malex_new/core/constants/api_constants.dart';
import 'package:malex_new/core/network/dio_client.dart';
import '../models/expense_model.dart';

class ExpenseRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<List<ExpenseModel>> getExpenses() async {
    final res = await _dio.get(ApiConstants.expenses);
    return (res.data as List).map((e) => ExpenseModel.fromJson(e)).toList();
  }

  Future<ExpenseModel> createExpense(ExpenseModel model) async {
    final res = await _dio.post(ApiConstants.expenses, data: model.toJson());
    return ExpenseModel.fromJson(res.data);
  }

  Future<ExpenseModel> updateExpense(String id, ExpenseModel model) async {
    final res =
        await _dio.put('${ApiConstants.expenses}/$id', data: model.toJson());
    return ExpenseModel.fromJson(res.data);
  }

  Future<void> deleteExpense(String id) async {
    await _dio.delete('${ApiConstants.expenses}/$id');
  }
}*/

// data/datasources/expense_remote_ds.dart
import 'package:dio/dio.dart';
import 'package:malex_new/core/constants/api_constants.dart';
import 'package:malex_new/core/network/dio_client.dart';
import 'package:malex_new/models/expense.dart';
import 'package:malex_new/screens/expenses/data/models/expense_model.dart';

class ExpenseRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<List<Expense>> getExpenses() async {
    try {
      final res = await _dio.get(ApiConstants.expenses);
      return (res.data as List).map((e) => Expense.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }

  Future<Expense> createExpense(Expense expense) async {
    try {
      final res = await _dio.post(ApiConstants.expenses, data: expense.toJson());
      return Expense.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to create expense: $e');
    }
  }

  Future<Expense> updateExpense(Expense expense, ExpenseModel model) async {
    try {
      final res = await _dio.put(
        '${ApiConstants.expenses}/${expense.id}',
        data: expense.toJson(),
      );
      return Expense.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _dio.delete('${ApiConstants.expenses}/$id');
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }
}