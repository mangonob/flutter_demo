import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class ShaderMaskDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        body: Center(
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow,
              Colors.red,
            ],
          ).createShader(rect);
        },
        child: const Text(
          "ShaderMask\n"
          "ShaderMask\n"
          "ShaderMask\n"
          "ShaderMask\n"
          "ShaderMask\n",
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}
