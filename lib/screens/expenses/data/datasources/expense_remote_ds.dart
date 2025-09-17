import 'package:dio/dio.dart';
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
}