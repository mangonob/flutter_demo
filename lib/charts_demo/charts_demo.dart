import 'package:flutter/material.dart';
import 'package:flutter_demo/charts_demo/line_chart_demo.dart';
import 'package:flutter_demo/charts_demo/pie_chart_demo.dart';

class ChartsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text(
          "Charts Demo",
          style: TextStyle(
            color: Color(0xFF181818),
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ListTile(
            title: Text("Pie Chart"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => PieChartDemo()),
            ),
          ),
          ListTile(
            title: Text("Line Chart"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => LineChartDemo()),
            ),
          ),
        ],
      ),
    );
  }
}
