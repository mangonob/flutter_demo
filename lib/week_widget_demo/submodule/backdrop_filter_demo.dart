import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class BackdropFilterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Hello Filter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    child: Center(
                      child: Text("NoFilter"),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text("Text in Column child"),
        ],
      ),
    );
  }
}
