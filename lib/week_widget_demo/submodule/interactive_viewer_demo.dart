import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class InteractiveViewerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: InteractiveViewer(
          constrained: false,
          boundaryMargin: EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                width: 1000,
                color: Colors.blue,
              ),
              Container(
                height: 500,
                width: 200,
                color: Colors.red,
              ),
              Container(
                height: 400,
                width: 400,
                color: Colors.yellow,
              ),
            ],
          )),
    );
  }
}
