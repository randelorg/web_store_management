import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class PurchasesOperation {
  Future<bool> sendToIncomingProducts(
      String orderSlipId, String supplierName) async {
    final status = "NOT RECEIVE";
    final orderSlip = "PO-$orderSlipId";

    var response;
    for (var item in Mapping.purchases) {
      try {
        var payload = json.encode({
          "purchaseOrdeSlip": orderSlip,
          "supplierName": supplierName,
          "productCode": item.productCode,
          "qty": item.qty,
          "purchasedDate": item.datePurchase,
          "status": status,
        });
        await Environment.methodPost(
                "http://localhost:8090/api/addpurchase", payload)
            .then((value) {
          response = value;
        });
      } catch (e) {
        e.toString();
        BannerNotif.notif(
          'Error',
          'Something went wrong while adding the loan',
          Colors.red.shade600,
        );
        return false;
      }
    }

    return true;
  }

  Future<bool> markAsRecieved(String poId) async {
    var response;
    final status = 'RECIEVED';
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/purchaseStatus/$poId/$status")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      Mapping.ordersList = parsed
          .map<IncomingPurchasesModel>(
              (json) => IncomingPurchasesModel.jsonOrder(json))
          .toList();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Cant fetch orders',
          Colors.red.shade600,
        );
        return false;
      }
    } catch (e) {
      print(e.toString());
      BannerNotif.notif(
        'Error',
        'Cant fetch orders',
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  Future<List<IncomingPurchasesModel>> getOrders(
      String orderId, String suppName, String date) async {
    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/incomingpurchases/$orderId/$suppName/$date")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      Mapping.ordersList = parsed
          .map<IncomingPurchasesModel>(
              (json) => IncomingPurchasesModel.jsonOrder(json))
          .toList();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Cant fetch orders',
          Colors.red.shade600,
        );
        return [];
      }
    } catch (e) {
      print(e.toString());
      BannerNotif.notif(
        'Error',
        'Cant fetch orders',
        Colors.red.shade600,
      );
      return [];
    }
    return Mapping.ordersList;
  }

  Future<List<IncomingPurchasesModel>> getProductItems(String barcode) async {
    var response;
    final String receive = "RECEIVED";
    String branchCode = '', branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });

    Mapping.branchList.forEach((element) {
      if (element.branchName == branchName) {
        branchCode = element.branchCode;
      }
    });

    try {
      await Environment.methodGet(
              "http://localhost:8090/api/item/$barcode/$receive/$branchCode")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      Mapping.productItems = parsed
          .map<IncomingPurchasesModel>(
              (json) => IncomingPurchasesModel.jsonItems(json))
          .toList();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Cant fetch orders',
          Colors.red.shade600,
        );
        return [];
      }
    } catch (e) {
      print(e.toString());
      BannerNotif.notif(
        'Error',
        'Cant fetch orders',
        Colors.red.shade600,
      );
      return [];
    }
    return Mapping.productItems;
  }

  Future<bool> customerPurchase(
      String invoiceNumber, String modeOfPayment) async {
    var response;

    String branchCode = '', branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });

    Mapping.branchList.forEach((element) {
      if (element.branchName == branchName) {
        branchCode = element.branchCode;
      }
    });

    for (var item in Mapping.invoice) {
      try {
        var payload = json.encode({
          "itemCode": item.itemCode,
          "modeOfPayment": modeOfPayment,
          "invoiceNumber": invoiceNumber,
          "prodCode": item.prodCode,
          "currentPrice": item.currentPrice,
          "date": Mapping.dateToday(),
          "branchCode": branchCode,
        });
        await Environment.methodPost(
                "http://localhost:8090/api/buyitem", payload)
            .then((value) {
          response = value;
        });
      } catch (e) {
        e.toString();
        BannerNotif.notif(
          'Error',
          'Something while buying',
          Colors.red.shade600,
        );
        return false;
      }
    }

    return true;
  }

  Future<List<IncomingPurchasesModel>> addToPurchaseTable(
      String barcode, int qty, String datePurchase) async {
    Mapping.productList
        .where((element) =>
            element.getProductCode?.toLowerCase() == barcode.toLowerCase())
        .forEach((element) {
      Mapping.purchases.add(IncomingPurchasesModel.purchase(
        element.getProductCode,
        element.getProductName,
        qty,
        element.getProdType,
        datePurchase,
      ));
    });
    return Mapping.purchases;
  }

  Future<bool> receivedItems() async {
    var response;
    String productCode = '';

    String branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });

    for (var item in Mapping.receiverOrders) {
      productCode = item.getProductCode;
      try {
        var payload = json.encode({
          "prodItemID": item.getProductItemCode,
          "prodCode": item.getProductCode,
          "remarks": item.getRemarks,
          "branchCode": Mapping.findBranchCode(branchName),
        });
        await Environment.methodPost(
                "http://localhost:8090/api/additem", payload)
            .then((value) {
          response = value;
        });
      } catch (e) {
        e.toString();
        BannerNotif.notif(
          'Error',
          'Something went wrong while adding the loan',
          Colors.red.shade600,
        );
        return false;
      }
    }

    try {
      var payload = json.encode({
        "prodCode": productCode,
      });
      await Environment.methodPost(
              "http://localhost:8090/api/onhandreceive", payload)
          .then((value) {
        response = value;
      });
    } catch (e) {
      e.toString();
      BannerNotif.notif(
        'Error',
        'Something while buying',
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  Future<List<IncomingPurchasesModel>> addToReceiveTable(
      String itemCode, String productCode, String remarks) async {
    Mapping.receiverOrders
        .add(IncomingPurchasesModel.receive(itemCode, remarks, productCode));
    return Mapping.receiverOrders;
  }

  Future<String> getProductInfo(String barcode) async {
    String productName = "";
    Mapping.productList
        .where((element) =>
            element.getProductCode?.toLowerCase() == barcode.toLowerCase())
        .forEach((element) {
      productName = element.getProductName;
    });
    return productName;
  }
}
