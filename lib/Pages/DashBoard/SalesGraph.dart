import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_store_management/Models/GraphModel.dart';

class SalesGraph extends StatefulWidget {
  final String? caption;
  final List<GraphModel>? graphData;
  SalesGraph({this.caption, this.graphData});
  @override
  _SalesGraph createState() => _SalesGraph();
}

class _SalesGraph extends State<SalesGraph> {
  @override
  void initState() {
    super.initState();
  }

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
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              crosshairBehavior: CrosshairBehavior(enable: true),
              trackballBehavior: TrackballBehavior(enable: true),
              series: <ChartSeries<GraphModel, String>>[
                LineSeries<GraphModel, String>(
                  //name: widget.caption.toString(),
                  dataSource: widget.graphData!.toList(),
                  xValueMapper: (GraphModel collection, _) =>
                      collection.getDateSold,
                  yValueMapper: (GraphModel collection, _) =>
                      collection.getSales,

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
