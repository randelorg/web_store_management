import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/Interfaces/IDashboard.dart';
import 'package:web_store_management/Models/Collection_model.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

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
    print(firstDayOfWeek);
    print(lastDayOfWeek);

    return [firstDayOfWeek, lastDayOfWeek];
  }

  @override
  void getMonthDates() {
    // TODO: implement getMonthDates
  }

  @override
  Future<double> getTodayCollection() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8090/api/today/' + getTodayDate()));

      var todayTotalCollection = jsonDecode(response.body)[0];

      var collection = CollectionModel.fromJsonToday(todayTotalCollection);

      if (response.statusCode == 404) {
        SnackNotification.notif(
 
          'Error',
          'Cant fetch loaned product history',
          Colors.red.shade600,
        );
        return 0;
      }

      return collection.getToday;
    } catch (e) {
      print(e.toString());
      SnackNotification.notif(

        'Error',
        'There is an error in fetching today collection',
        Colors.red.shade600,
      );
      return 0;
    }
  }

  @override
  Future<double> getWeekCollection() async {
    List<String> dates = getWeekDates();
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:8090/api/week/' + dates[0] + '/' + dates[1]));

      var weekTotalCollection = jsonDecode(response.body)[0];

      var collection = CollectionModel.fromJsonWeek(weekTotalCollection);

      if (response.statusCode == 404) {
        SnackNotification.notif(

          'Error',
          'Cant fetch loaned product history',
          Colors.red.shade600,
        );
        return 0;
      }

      return collection.getWeek;
    } catch (e) {
      print(e.toString());
      SnackNotification.notif(

        'Error',
        'There is an error in fetching today collection',
        Colors.red.shade600,
      );
      return 0;
    }
  }

  @override
  Future<double> getMonthCollection() {
    // TODO: implement getMonthCollection
    throw UnimplementedError();
  }
}
