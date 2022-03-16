import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/LoanedProductHistoryModel.dart';
import 'package:web_store_management/Models/PaymentHistoryModel.dart';

class IHistory {
  Future<List<PaymentHistoryModel>> viewPaymentHistory(String userId) async {
    throw UnimplementedError();
  }

  Future<List<LoanedProductHistory>> viewLoanHistory(String userId) {
    throw UnimplementedError();
  }
}
