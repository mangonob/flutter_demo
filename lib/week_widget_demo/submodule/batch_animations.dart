import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/week_widget_demo/submodule/curve_demo/auto_reversed_curve.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class BatchAnimations extends StatefulWidget {
  @override
  _BatchAnimationsState createState() => _BatchAnimationsState();
}

class _BatchAnimationsState extends State<BatchAnimations> {
  late Random random;

  @override
  void initState() {
    super.initState();
    random = Random.secure();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: List.generate(100, (index) {
                  return _Tile(
                    value: random.nextInt(1024),
                  );
                }),
                spacing: 10,
                runSpacing: 8,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Reload"),
            )
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final int value;

  _Tile({
    required this.value,
  });

  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _delta = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Tile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _delta = widget.value - oldWidget.value;
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
      ),
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) {
            final aniColor = _delta >= 0 ? Colors.red : Colors.green;

            final color =
                ColorTween(begin: aniColor.withAlpha(0), end: aniColor).lerp(
              AutoReversedCurve(Curves.easeOutExpo)
                  .transform(_animationController.value),
            );

            return Container(
              padding: EdgeInsets.all(1),
              color: color,
            );
          }),
    );
  }
}
