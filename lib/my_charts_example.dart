import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/charts/charts.dart';
import 'package:flutter_demo/widgets/charts/line_chart/axis.dart';
import 'package:flutter_demo/widgets/charts/line_chart/serie.dart';
import 'package:flutter_demo/widgets/charts/line_chart/style.dart';

class MyChartsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              style: LineChartStyle().copyWith(
                indicatorSize: Size(6, 6),
                indicator: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              xAxis: LineChartAxis(
                style: LineChartAxisStyle(
                  firstLabelAlignment: Alignment.bottomRight,
                  labelAlignment: Alignment.bottomCenter,
                  lastLabelAlignment: Alignment.bottomLeft,
                  labelPadding: EdgeInsets.symmetric(vertical: 2),
                ),
              ),
              series: [
                LineChartSerie(
                  data: List.generate(
                    100,
                    (index) => {"x": index, "y": index * index},
                  ),
                  style: LineChartSerieStyle(
                    lineStyle: LineStyle(color: Colors.red),
                  ),
                ),
                LineChartSerie(
                  data: List.generate(
                    20,
                    (index) => {"x": index * 10, "y": 400 * sqrt(index * 10)},
                  ),
                  style: LineChartSerieStyle(
                    lineStyle: LineStyle(color: Colors.yellow),
                  ),
                  onActived: (data) {
                    print(data);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
