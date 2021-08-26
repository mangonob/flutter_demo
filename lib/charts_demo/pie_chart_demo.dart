import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/charts/pie_chart/pie_chart.dart';
import 'package:flutter_demo/widgets/charts/pie_chart/serie.dart';
import 'package:flutter_demo/widgets/charts/pie_chart/style.dart';

class PieChartDemo extends StatefulWidget {
  @override
  _PieChartDemoState createState() => _PieChartDemoState();
}

class _PieChartDemoState extends State<PieChartDemo> {
  late List<num> datas;

  @override
  void initState() {
    super.initState();

    _generateData();
  }

  _generateData() {
    datas = List.generate(12, (index) => Random.secure().nextDouble());
  }

  @override
  Widget build(BuildContext context) {
    final serieStyle = PieChartSerieStyle(
      leadingLineLength: 15,
      labelStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
      outerRadius: 65,
      innerRadius: 44,
      labelPadding: EdgeInsets.symmetric(horizontal: 4, vertical: -2),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                series: [
                  PieChartSerie(
                    debugLabel: "default",
                    style: serieStyle,
                    data: datas,
                    valueFn: (v, i) =>
                        v / datas.fold(0, (a, b) => (a as num) + b),
                    isSkipDrawWhenEmpty: false,
                    colorFn: _colorFn,
                    lineColorFn: _colorFn,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => setState(() => _generateData()),
              child: Text("Random"),
            ),
          ],
        ),
      ),
    );
  }

  Color? _colorFn(dynamic d, int index) {
    final tween = ColorTween(begin: Colors.red[400], end: Colors.yellow[600]);
    return tween.lerp(index.toDouble() / (datas.length - 1));
  }
}
