import 'package:web_store_management/Models/BorrowerModel.dart';

class Invoice {
  final InvoiceInfo info;
  final BorrowerModel customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
  });
}

class InvoiceItem {
  final String description;
  final int quantity;
  double vat = 0;
  final double unitPrice;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
