import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/interfaces/IDashboard.dart';
import 'package:web_store_management/Models/CollectionModel.dart';
import 'package:web_store_management/Models/GraphModel.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'package:web_store_management/Backend/Session.dart';

class DashboardOperation implements IDashboard {
  late final BuildContext context;
  var _formatter = new DateFormat('yyyy-MM-dd');
  var _now = new DateTime.now();

  @override
  String getTodayDate() {
    String formattedDate = _formatter.format(_now);
    return formattedDate;
  }

  @override
  List<String> getWeekDates() {
    var weekDay = _now.weekday;
    var firstDayOfWeek =
        _formatter.format(_now.subtract(Duration(days: weekDay - 1)));
    var lastDayOfWeek =
        _formatter.format(_now.add(Duration(days: 7 - weekDay)));

    return [firstDayOfWeek, lastDayOfWeek];
  }

  @override
  List<String> getMonthDates() {
    var monthDay = _now;
    var firstDayOfMonth =
        _formatter.format(DateTime.utc(monthDay.year, monthDay.month, 1));
    var lastDayOfMonth = _formatter.format(
        DateTime.utc(monthDay.year, monthDay.month + 1)
            .subtract(Duration(days: 1)));

    return [firstDayOfMonth, lastDayOfMonth];
  }

  @override
  Future<double> getTodaySales() async {
    String branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });

    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/today/${getTodayDate()}/${Mapping.findBranchCode(branchName)}")
          .then((value) {
        response = value;
      });

      var todayTotalSales = jsonDecode(response.body)[0];

      var collection = SalesModel.fromJsonToday(todayTotalSales);

      if (response.statusCode == 404) {
        return 0;
      }

      return collection.getToday;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<double> getWeekSales() async {
    String branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });

    List<String> dates = getWeekDates();
    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/week/${dates[0]}/${dates[1]}/${Mapping.findBranchCode(branchName)}")
          .then((value) {
        response = value;
      });

      var weekTotalSales = jsonDecode(response.body)[0];

      var collection = SalesModel.fromJsonWeek(weekTotalSales);

      if (response.statusCode == 404) {
        return 0;
      }

      return collection.getWeek;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<double> getMonthSales() async {
    String branchName = '';

    await Session.getBranch().then((branch) {
      branchName = branch;
    });
    List<String> dates = getMonthDates();
    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/week/${dates[0]}/${dates[1]}/${Mapping.findBranchCode(branchName)}")
          .then((value) {
        response = value;
      });

      var monthTotalSales = jsonDecode(response.body)[0];

      var collection = SalesModel.fromJsonWeek(monthTotalSales);

      if (response.statusCode == 404) {
        return 0;
      }

      return collection.getWeek;
    } catch (e) {
      return 0;
    }
  }

  Future<double> getWeekCollection() async {
    List<String> dates = getWeekDates();
    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/weekcollection/${dates[0]}/${dates[1]}")
          .then((value) {
        response = value;
      });

      var weekTotalCollection = jsonDecode(response.body)[0];

      var collection = CollectionModel.fromJsonWeek(weekTotalCollection);

      if (response.statusCode == 404) {
        return 0;
      }

      return collection.getWeek;
    } catch (e) {
      return 0;
    }
  }

  //TODO: implement sales graph here and return a list of GraphCollectionModel
  //TODO: modify the api endpoint to get the sales data
  @override
  Future<List<GraphModel>> getGraphWeek() async {
    List<String> dates = getWeekDates();
    List<GraphModel> graphCollection = [];
    var response;

    try {
      await Environment.methodGet(
              "http://localhost:8090/api/datesales/${dates[0]}/${dates[1]}")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      graphCollection = parsed
          .map<GraphModel>((json) => GraphModel.fromJsonSales(json))
          .toList();

      if (response.statusCode == 404) {
        return [];
      }

      return graphCollection;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<GraphModel>> getGraphMonth() {
    // TODO: implement getGraphMonth
    throw UnimplementedError();
  }

  @override
  Future<List<GraphModel>> getCollectionGraphReport(
      String startDate, String endDate) async {
    if (startDate == '' && endDate == '') {
      return [];
    }

    List<GraphModel> graphCollection = [];
    var response;

    try {
      await Environment.methodGet(
              "http://localhost:8090/api/datecollection/$startDate/$endDate")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      graphCollection = parsed
          .map<GraphModel>((json) => GraphModel.fromJsonCollection(json))
          .toList();

      if (response.statusCode == 404) {
        return [];
      }

      return graphCollection;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<GraphModel>> getSalesGraphReport(
      String startDate, String endDate) async {
    if (startDate == '' && endDate == '') {
      return [];
    }

    List<GraphModel> graphCollection = [];
    var response;

    try {
      await Environment.methodGet(
              "http://localhost:8090/api/datesales/$startDate/$endDate")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      graphCollection = parsed
          .map<GraphModel>((json) => GraphModel.fromJsonSales(json))
          .toList();

      if (response.statusCode == 404) {
        return [];
      }

      return graphCollection;
    } catch (e) {
      return [];
    }
  }
}
