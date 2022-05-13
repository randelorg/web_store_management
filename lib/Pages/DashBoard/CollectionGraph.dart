import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_store_management/Models/GraphCollectionModel.dart';

class CollectionGraph extends StatefulWidget {
  final String? caption;
  final List<GraphCollectionModel>? graphData;
  CollectionGraph({this.caption, this.graphData});
  @override
  _CollectionGraph createState() => _CollectionGraph();
}

class _CollectionGraph extends State<CollectionGraph> {
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
              series: <ChartSeries<GraphCollectionModel, String>>[
                LineSeries<GraphCollectionModel, String>(
                  //name: widget.caption.toString(),
                  dataSource: widget.graphData!.toList(),
                  xValueMapper: (GraphCollectionModel collection, _) =>
                      collection.getGivenDate,
                  yValueMapper: (GraphCollectionModel collection, _) =>
                      collection.getCollection,

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
