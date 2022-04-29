import 'package:web_store_management/Models/GraphCollectionModel.dart';

class IDashboard {

  String getTodayDate() {
    return '';
  }

  List<String> getWeekDates() {
    return [];
  }

  List<String> getMonthDates() {
    return [];
  }

  Future<double> getWeekCollection() async {
    return 0;
  }

  Future<double> getTodayCollection() async {
    return 0;
  }

  Future<double> getMonthCollection() async {
    return 0;
  }

  //this is for the graph {week and month}
  Future<List<GraphCollectionModel>> getGraphWeek() async {
    var a;
    return a;
  }

  //this is for the graph {week and month}
  Future<List<GraphCollectionModel>> getGraphMonth() async {
    var a;
    return a;
  }

  //this is for the graph {week and month}
  Future<List<GraphCollectionModel>> getGraphReport(
      String startDate, String endDate) async {
    var a;
    return a;
  }
}
