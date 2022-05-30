import 'package:intl/intl.dart';

class GraphModel {
  String? givenDate;
  String? dateSold;
  double? collection;
  double? sales;

  get getSales => this.sales;

  set setSales(sales) => this.sales = sales;

  get getDateSold => convertDateTimeDisplay(this.dateSold.toString());

  set setDateSold(dateSold) => this.dateSold = dateSold;

  get getGivenDate => convertDateTimeDisplay(this.givenDate.toString());

  set setGivenDate(String givenDate) => this.givenDate = givenDate;

  get getCollection => this.collection;

  set setCollection(collection) => this.collection = collection;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  GraphModel.empty();

  GraphModel(String givenDate, double collection) {
    this.givenDate = givenDate;
    this.collection = collection;
  }

  GraphModel.sales({
    this.dateSold,
    this.sales,
  });

  factory GraphModel.fromJsonSales(Map<String, dynamic> json) {
    return GraphModel.sales(
      dateSold: json["DateSold"] as String,
      sales: json["Sales"] as double,
    );
  }

  GraphModel.collection({
    this.givenDate,
    this.collection,
  });

  factory GraphModel.fromJsonCollection(Map<String, dynamic> json) {
    return GraphModel.collection(
      givenDate: json["GivenDate"] as String,
      collection: json["Collection"] as double,
    );
  }
}
