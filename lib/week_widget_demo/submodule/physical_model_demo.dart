import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class PhysicalModelDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Center(
        child: PhysicalModel(
          color: Colors.red,
          shadowColor: Colors.black,
          shape: BoxShape.circle,
          elevation: 8,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.blue.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
