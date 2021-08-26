import 'package:flutter/material.dart';

import 'area.dart';
import 'axis.dart';
import 'grid.dart';
import 'painter/axis_painter.dart';
import 'painter/grid_painter.dart';
import 'painter/line_chart_painter.dart';
import 'painter/series_paint.dart';
import 'serie.dart';
import 'style.dart';

enum LineChartLabelPosition {
  top,
  bottom,
  right,
  left,
}

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
  final void Function(Offset? fractionPosition)? onFractionPositionChanged;
  final void Function(Offset? position, Size size)? onPositionChanged;
  final Offset Function(Offset indicatorPosition, Offset userPosition)?
      customIndicatorPosition;
  final disactiveOnPanCancel;
  final disactiveOnTapCancel;

  LineChart({
    Key? key,
    LineChartGrid? grid,
    this.xAxis = const LineChartAxis(
      style: LineChartAxisStyle(
        labelStyle: LineChartAxisLabelStyle(alignment: Alignment.bottomCenter),
      ),
    ),
    this.yAxis = const LineChartAxis(
      style: LineChartAxisStyle(
        labelStyle: LineChartAxisLabelStyle(alignment: Alignment.topRight),
      ),
    ),
    this.rightAxis,
    this.series = const [],
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.style = const LineChartStyle(),
    this.onDisactived,
    this.disactiveOnPanCancel = true,
    this.disactiveOnTapCancel = true,
    this.onFractionPositionChanged,
    this.onPositionChanged,
    this.customIndicatorPosition,
  })  : grid = grid ??
            LineChartGrid(
              verticalSpan: 30,
              horizontalSpan: 30,
              areaColors: (i, j) =>
                  (i + j) % 2 == 0 ? Colors.orange : Colors.orangeAccent,
            ),
        super(key: key);

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
      onTapDown: (d) {
        setState(() => _activePosition = d.localPosition);
        _drivePositionCallback(d.localPosition);
      },
      onTapUp: (d) {
        if (widget.disactiveOnTapCancel) {
          setState(() => _activePosition = null);
          _drivePositionCallback(null);
          if (widget.onDisactived != null) widget.onDisactived!();
        }
      },
      onPanUpdate: (d) {
        setState(() => _activePosition = d.localPosition);
        _drivePositionCallback(d.localPosition);
      },
      onPanEnd: (d) {
        if (widget.disactiveOnPanCancel) {
          setState(() => _activePosition = null);
          _drivePositionCallback(null);
          if (widget.onDisactived != null) widget.onDisactived!();
        }
      },
      child: ClipRect(
        child: RepaintBoundary(
          child: CustomPaint(
            painter: LineChartGridPainter(
              grid: widget.grid,
              area: _area(),
              padding: widget.padding,
            ),
            child: CustomPaint(
              painter: LineChartAxisPainter(
                xAxis: widget.xAxis,
                yAxis: widget.yAxis,
                rightAxis: widget.rightAxis,
                area: _area(),
                padding: widget.padding,
              ),
              child: LineChartSeriesPaint(
                series: widget.series,
                area: _area(),
                padding: widget.padding,
                activePosition: _activePosition,
              ),
            ),
            foregroundPainter: LineChartPainter(
              grid: widget.grid,
              xAxis: widget.xAxis,
              yAxis: widget.yAxis,
              rightAxis: widget.rightAxis,
              series: widget.series,
              activePosition: _activePosition,
              padding: widget.padding,
              style: widget.style,
              customIndicatorPosition: widget.customIndicatorPosition,
              area: _area(),
            ),
          ),
        ),
      ),
    );
  }

  _drivePositionCallback(Offset? position) {
    if (context.size == null) return;

    final size = Size(
      context.size!.width - widget.padding.left - widget.padding.right,
      context.size!.height - widget.padding.top - widget.padding.bottom,
    );

    final relativePosition = position != null
        ? position.translate(-widget.padding.left, -widget.padding.top)
        : null;

    if (widget.onFractionPositionChanged != null) {
      final callback = widget.onFractionPositionChanged!;

      if (relativePosition != null && context.size != null) {
        callback(Offset(relativePosition.dx / size.width,
            relativePosition.dy / size.height));
      } else {
        callback(null);
      }
    }

    if (widget.onPositionChanged != null) {
      final callback = widget.onPositionChanged!;

      if (context.size != null) {
        final size = context.size!;

        if (relativePosition != null) {
          callback(Offset(relativePosition.dx, relativePosition.dy), size);
        } else if (context.size != null) {
          callback(null, size);
        }
      }
    }
  }

  _area() => Area(_xRange(), _yRange());

  _xRange() => widget.xAxis.range(() => widget.series.map((s) => s.xRange));

  _yRange() => widget.yAxis.range(() => widget.series.map((s) => s.yRange));
}
