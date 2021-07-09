import 'package:flutter/material.dart';

import 'date-time-builder.dart';

class Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BarTitle(),
        toolbarHeight: 44,
      ),
      body: ListView(
        children: List.generate(1000, (index) {
          return ListTile(
            onTap: () {},
            title: DateTimeBuilder(builder: (ctx, time) {
              return Text(
                "$index: ${time.toIso8601String()}",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF181818),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class BarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 2)
                  .copyWith(top: 1, bottom: 1),
              child: Text(
                "HK",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "腾讯控股",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF181818),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                "00700",
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF999999),
                ),
              ),
            ),
          ],
        ),
        DateTimeBuilder(builder: (ctx, time) {
          return Text(
            time.toIso8601String(),
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF666666),
            ),
          );
        }),
      ],
    );
  }
}
