import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CollectionGraph extends StatelessWidget 
{
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  CollectionGraph(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory CollectionGraph.withSampleData() {
    return new CollectionGraph(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      //  behaviors: [
      //   new charts.ChartTitle(
      //       'COLLECTIONS',
      //       titleStyleSpec: charts.TextStyleSpec(
      //         color: charts.ColorUtil.fromDartColor(Colors.blue),
      //         fontSize: 35,
      //       ),
      //       subTitle: 'Top sub-title text',
      //       subTitleStyleSpec: charts.TextStyleSpec(
      //         //color: charts.ColorUtil.fromDartColor(Colors.blue),
      //         fontSize: 25,
      //       ),
      //       behaviorPosition: charts.BehaviorPosition.top,
      //       titleOutsideJustification: charts.OutsideJustification.start,
      //       // Set a larger inner padding than the default (10) to avoid
      //       // rendering the text too close to the top measure axis tick label.
      //       // The top tick label may extend upwards into the top margin region
      //       // if it is located at the top of the draw area.
      //       innerPadding: 80,
      //       outerPadding: 20,
      //   ),
      // ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 30),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales 
{
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}