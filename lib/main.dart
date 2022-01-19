import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Routes.first: (_) => OnlyText(text: "first"),
        Routes.second: (_) => OnlyText(text: "second"),
        Routes.third: (_) => OnlyText(text: "third"),
      },
      title: "My app",
      home: Home(),
      builder: EasyLoading.init(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  double _offset = 0;
  int _itemCount = 42;
  double _itemWidth = 50;
  late RandomColor _randomColor;
  late List<Color> _colors;
  late BouncingScrollPhysics _physics;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _randomColor = RandomColor();
    _colors = List.generate(42, (_) => _randomColor.randomColor());
    _physics = BouncingScrollPhysics();
    _animationController = AnimationController.unbounded(vsync: this);
    _animationController.addListener(_aniListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _aniListener() {
    setState(() {
      _offset = _animationController.value;
    });
  }

  ScrollMetrics createMetrics(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    final width = box?.size.width ?? 0;

    return FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: _itemCount * _itemWidth - width,
      pixels: _offset,
      viewportDimension: width,
      axisDirection: AxisDirection.right,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 44),
      body: GestureDetector(
        onScaleUpdate: (d) {
          _animationController.stop();
          if (d.pointerCount == 1) {
            setState(() {
              final delta = d.focalPointDelta.dx;
              if (delta != 0) {
                _offset += _physics.applyPhysicsToUserOffset(
                  createMetrics(context),
                  -delta,
                );
              }
            });
          }
        },
        onScaleEnd: (d) {
          if (d.pointerCount == 0) {
            final simulation = _physics.createBallisticSimulation(
                createMetrics(context), -d.velocity.pixelsPerSecond.dx);
            if (simulation != null) {
              _animationController.animateWith(simulation);
            }
          }
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: -_offset,
                bottom: 0,
                child: Row(
                  children: List.generate(_itemCount, (index) {
                    return Container(
                      width: _itemWidth,
                      color: _colors[index % _colors.length],
                      child: Center(
                        child: Text("$index"),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
