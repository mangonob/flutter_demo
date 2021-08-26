import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/charts/charts.dart';
import 'package:flutter_demo/widgets/charts/line_chart/serie.dart';
import 'package:flutter_demo/widgets/charts/line_chart/style.dart';

class LineChartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(
            style: LineChartStyle(
              verticalIndicatorLine: LineStyle(width: 1),
              horizontalIndicatorLine: LineStyle(width: 1),
            ),
            series: [
              LineChartSerie(
                data: [
                  {"x": 1, "y": 98},
                  {"x": 2, "y": 14},
                  {"x": 3, "y": 200},
                  {"x": 4, "y": 34},
                ],
                onActived: (_) {},
                indicatorLabelFormatter: (d, p) {
                  switch (p) {
                    case LineChartLabelPosition.top:
                      return "top $d";
                    case LineChartLabelPosition.bottom:
                      return "bottom $d";
                    case LineChartLabelPosition.left:
                      return "left $d";
                    case LineChartLabelPosition.right:
                      return "right $d";
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
