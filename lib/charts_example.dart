import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class ChartsExample extends StatefulWidget {
  @override
  _ChartsExampleState createState() => _ChartsExampleState();
}

class _ChartsExampleState extends State<ChartsExample> {
  Key _chartKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () => setState(() => _chartKey = UniqueKey()),
            child: Center(
              child: Container(
                key: _chartKey,
                height: 120,
                width: 120,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: IgnorePointer(
                  child: PieChart(
                    [
                      Series<Sales, int>(
                        id: "pie",
                        data: [
                          Sales(0, 100),
                          Sales(1, 50),
                          Sales(2, 75),
                          Sales(3, 30),
                        ],
                        domainFn: (d, _) => d.year,
                        measureFn: (d, _) => d.sales,
                        colorFn: (s, a) {
                          return Color(
                            r: 255,
                            g: 50 * (a ?? 0),
                            b: 0,
                          );
                        },
                      ),
                    ],
                    animationDuration: Duration(seconds: 1),
                    layoutConfig: LayoutConfig(
                      leftMarginSpec: MarginSpec.fixedPixel(0),
                      topMarginSpec: MarginSpec.fixedPixel(0),
                      rightMarginSpec: MarginSpec.fixedPixel(0),
                      bottomMarginSpec: MarginSpec.fixedPixel(0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Sales {
  final int year;
  final int sales;

  Sales(this.year, this.sales);
}
