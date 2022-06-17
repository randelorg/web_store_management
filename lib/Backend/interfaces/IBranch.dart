import 'package:web_store_management/Models/ProductTranferHistoryModel.dart';

class IBranch {
  Future<bool> addBranch(
      String branchName, String branchAddress, String empId) {
    var a;
    return a;
  }

  Future<bool> deleteBranch() {
    var a;
    return a;
  }

  Future<bool> updateBranch(
      String branchCode, String branchName, String branchAddress) {
    var a;
    return a;
  }

  Future<List<ProductTransferHistoryModel>> transferStock(
      String productCode, int qty, String branchCode) {
    var a;
    return a;
  }
}
