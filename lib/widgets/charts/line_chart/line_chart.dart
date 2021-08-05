import 'package:flutter/material.dart';

import 'area.dart';
import 'axis.dart';
import 'grid.dart';
import 'painter/line_chart_painter.dart';
import 'serie.dart';
import 'style.dart';

class LineChart extends StatefulWidget {
  final LineChartStyle style;
  final LineChartGrid? grid;
  final LineChartAxis xAxis;
  final LineChartAxis yAxis;
  final LineChartAxis? rightAxis;
  final List<LineChartSerie> series;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final void Function()? onDisactived;
  final disactiveOnPanCancel;
  final disactiveOnTapCancel;

  LineChart({
    LineChartGrid? grid,
    this.xAxis = const LineChartAxis(
      style: LineChartAxisStyle(
        labelAlignment: Alignment.bottomCenter,
      ),
    ),
    this.yAxis = const LineChartAxis(
      style: LineChartAxisStyle(labelAlignment: Alignment.topRight),
    ),
    this.rightAxis,
    this.series = const [],
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.style = const LineChartStyle(),
    this.onDisactived,
    this.disactiveOnPanCancel = true,
    this.disactiveOnTapCancel = false,
  })  : grid = grid ??
            LineChartGrid(
              verticalSpanCount: 4,
              horizontalSpanCount: 5,
              areaColors: (i, j) => (i + j) % 2 == 0
                  ? (Colors.blue[200] ?? Colors.blue)
                  : (Colors.blue[100] ?? Colors.blue),
            ),
        super();

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  Offset? _activePosition;

  @override
  void didUpdateWidget(covariant LineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (d) {
        setState(() => _activePosition = d.localPosition);
      },
      onTapUp: (d) {
        if (widget.disactiveOnTapCancel) {
          setState(() => _activePosition = null);
          if (widget.onDisactived != null) widget.onDisactived!();
        }
      },
      onPanUpdate: (d) {
        setState(() => _activePosition = d.localPosition);
      },
      onPanEnd: (d) {
        if (widget.disactiveOnPanCancel) {
          setState(() => _activePosition = null);
          if (widget.onDisactived != null) widget.onDisactived!();
        }
      },
      child: Container(
        color: widget.backgroundColor ?? Colors.white,
        child: CustomPaint(
          painter: LineChartPainter(
            grid: widget.grid,
            xAxis: widget.xAxis,
            yAxis: widget.yAxis,
            rightAxis: widget.rightAxis,
            series: widget.series,
            activePosition: _activePosition,
            padding: widget.padding,
            style: widget.style,
            area: _area(),
          ),
        ),
      ),
    );
  }

  _area() => Area(_xRange(), _yRange());

  _xRange() => widget.xAxis.range(() => widget.series.map((s) => s.xRange));

  _yRange() => widget.yAxis.range(() => widget.series.map((s) => s.yRange));
}
