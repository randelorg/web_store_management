import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/Interfaces/IDashboard.dart';
import 'package:web_store_management/Models/CollectionModel.dart';
import 'package:web_store_management/Models/GraphCollectionModel.dart';
import 'package:web_store_management/environment/Environment.dart';

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
  Future<double> getTodayCollection() async {
    var response;
    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/today/${getTodayDate()}")
          .then((value) {
        response = value;
      });

      var todayTotalCollection = jsonDecode(response.body)[0];

      var collection = CollectionModel.fromJsonToday(todayTotalCollection);

      if (response.statusCode == 404) {
        return 0;
      }

      return collection.getToday;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<double> getWeekCollection() async {
    List<String> dates = getWeekDates();
    var response;
    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/week/${dates[0]}/${dates[1]}")
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

  @override
  Future<double> getMonthCollection() async {
    List<String> dates = getMonthDates();
    var response;
    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/week/${dates[0]}/${dates[1]}")
          .then((value) {
        response = value;
      });

      var monthTotalCollection = jsonDecode(response.body)[0];

      var collection = CollectionModel.fromJsonWeek(monthTotalCollection);

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
  Future<List<GraphCollectionModel>> getGraphWeek() async {
    List<String> dates = getMonthDates();
    List<GraphCollectionModel> graphCollection = [];
    var response;

    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/datecollection/${dates[0]}/${dates[1]}")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      graphCollection = parsed
          .map<GraphCollectionModel>(
              (json) => GraphCollectionModel.fromJson(json))
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
  Future<List<GraphCollectionModel>> getGraphMonth() {
    // TODO: implement getGraphMonth
    throw UnimplementedError();
  }

  @override
  Future<List<GraphCollectionModel>> getGraphReport(
      String startDate, String endDate) async {
    if (startDate == '' && endDate == '') {
      return [];
    }

    List<GraphCollectionModel> graphCollection = [];
    var response;

    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/datecollection/$startDate/$endDate")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      graphCollection = parsed
          .map<GraphCollectionModel>(
              (json) => GraphCollectionModel.fromJson(json))
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
