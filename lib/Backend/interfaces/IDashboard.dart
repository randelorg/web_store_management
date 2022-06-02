import 'package:web_store_management/Models/GraphModel.dart';

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

  Future<double> getWeekSales() async {
    return 0;
  }

  Future<double> getTodaySales() async {
    return 0;
  }

  Future<double> getMonthSales() async {
    return 0;
  }

  //this is for the graph {week and month}
  Future<List<GraphModel>> getGraphWeek() async {
    var a;
    return a;
  }

  //this is for the graph {week and month}
  Future<List<GraphModel>> getGraphMonth() async {
    var a;
    return a;
  }

  //this is for the graph {week and month}
  Future<List<GraphModel>> getCollectionGraphReport(
      String startDate, String endDate) async {
    var a;
    return a;
  }

  //this is for the graph {week and month}
  Future<List<GraphModel>> getSalesGraphReport(
      String startDate, String endDate) async {
    var a;
    return a;
  }
}
