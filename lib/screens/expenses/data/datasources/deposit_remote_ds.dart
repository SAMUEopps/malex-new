// data/datasources/deposit_remote_ds.dart
import 'package:dio/dio.dart';
import 'package:malex_new/core/constants/api_constants.dart';
import 'package:malex_new/core/network/dio_client.dart';
import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';

class DepositRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<List<CashDeposit>> getDeposits() async {
    try {
      final res = await _dio.get(ApiConstants.deposits);
      return (res.data as List).map((e) => CashDeposit.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch deposits: $e');
    }
  }

  Future<CashDeposit> createDeposit(CashDeposit deposit) async {
    try {
      final res = await _dio.post(ApiConstants.deposits, data: deposit.toJson());
      return CashDeposit.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to create deposit: $e');
    }
  }

  Future<CashDeposit> updateDeposit(String id, CashDeposit deposit) async {
    try {
      final res = await _dio.put(
        '${ApiConstants.deposits}/$id',
        data: deposit.toJson(),
      );
      return CashDeposit.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to update deposit: $e');
    }
  }

  Future<void> deleteDeposit(String id) async {
    try {
      await _dio.delete('${ApiConstants.deposits}/$id');
    } catch (e) {
      throw Exception('Failed to delete deposit: $e');
    }
  }
}