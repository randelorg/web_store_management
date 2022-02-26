import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CollectionGraph extends StatefulWidget {
  @override
  _CollectionGraph createState() => _CollectionGraph();
}

class _CollectionGraph extends State<CollectionGraph> {
  List<_SalesData> month = [
    _SalesData('Jan', 1000),
    _SalesData('Feb', 8000),
    _SalesData('Mar', 190000),
    _SalesData('Apr', 70000),
    _SalesData('May', 40000)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Collection'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  name: 'Month',
                  dataSource: month,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
