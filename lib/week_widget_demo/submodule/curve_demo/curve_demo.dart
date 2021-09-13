import 'package:flutter/material.dart';
import 'package:flutter_demo/week_widget_demo/submodule/curve_demo/auto_reversed_curve.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class CurveDemo extends StatefulWidget {
  @override
  _CurveDemoState createState() => _CurveDemoState();
}

class _CurveDemoState extends State<CurveDemo> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, child) {
                final value = AutoReversedCurve(Curves.easeOutExpo)
                    .transform(_animationController.value);

                final color = ColorTween(
                        begin: Color(0x0018B078),
                        end: Color(0xFF18B078).withOpacity(0.2))
                    .lerp(value);

                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [color!.withAlpha(0), color],
                    ),
                  ),
                  child: child,
                );
              },
              child: Container(
                child: FlutterLogo(),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _animationController.forward(from: 0);
                });
              },
              child: Text("Run Animate"),
            )
          ],
        ),
      ),
    );
  }
}
