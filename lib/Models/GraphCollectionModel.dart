import 'package:intl/intl.dart';

class GraphCollectionModel {
  String? givenDate;
  double? collection;

  get getGivenDate => convertDateTimeDisplay(this.givenDate.toString());

  set setGivenDate(String givenDate) => this.givenDate = givenDate;

  get getCollection => this.collection;

  set setCollection(collection) => this.collection = collection;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);

    print(formatted);
    return formatted;
  }

  GraphCollectionModel(String givenDate, double collection) {
    this.givenDate = givenDate;
    this.collection = collection;
  }

  GraphCollectionModel.full({
    this.givenDate,
    this.collection,
  });

  factory GraphCollectionModel.fromJson(Map<String, dynamic> json) {
    return GraphCollectionModel.full(
      givenDate: json["GivenDate"] as String,
      collection: json["Collection"] as double,
    );
  }
}
