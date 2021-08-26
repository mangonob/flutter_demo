import 'dart:ui';

import 'package:flutter_demo/widgets/charts/charts.dart';
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

import 'range.dart';
import 'style.dart';

typedef ValueConvertor<T> = num Function(T v, int index);

///
/// Example:
/// ```dart
/// ```
class LineChartSerie<D> {
  final LineChartSerieStyle style;
  final List<D> data;
  late ValueConvertor<D> xValue;
  late ValueConvertor<D> yValue;
  final void Function(dynamic data)? onActived;
  final void Function()? onDeactived;
  final String? Function(D data, LineChartLabelPosition position)?
      indicatorLabelFormatter;

  /// Custom series for each points.
  final LineChartSerieStyle? Function(D x, int index)? styles;

  LineChartSerie({
    this.style = const LineChartSerieStyle(),
    required this.data,
    ValueConvertor<D>? xValue,
    ValueConvertor<D>? yValue,
    this.styles,
    this.onActived,
    this.onDeactived,
    this.indicatorLabelFormatter,
  }) {
    this.xValue = xValue ??
        ((d, _) {
          assert(d is Map);
          assert((d as Map).containsKey("x"));
          return (d as Map)["x"];
        });

    this.yValue = yValue ??
        ((d, _) {
          assert(d is Map);
          assert((d as Map).containsKey("y"));
          return (d as Map)["y"];
        });
  }

  Range get xRange {
    final xValues = enumerate(data).map((d) => xValue(d.value, d.index));

    return Range.all.copyWith(
      low: min(xValues),
      high: max(xValues),
    );
  }

  Range get yRange {
    final yValues = enumerate(data).map((d) => yValue(d.value, d.index));

    return Range.all.copyWith(
      low: min(yValues),
      high: max(yValues),
    );
  }

  List<Offset>? _points;

  List<Offset> get points {
    if (_points == null) {
      _points = enumerate(data)
          .map((d) => Offset(
                xValue(d.value, d.index).toDouble(),
                yValue(d.value, d.index).toDouble(),
              ))
          .toList();
    }
    return _points!;
  }

  Tuple2<D, Offset>? nearest({
    required Offset point,
    required bool inHorizontal,
  }) {
    final pointAndIndex =
        min<IndexedValue<Offset>>(enumerate(points), (p1, p2) {
      if (inHorizontal) {
        return ((p1.value.dx - point.dx).abs() - (p2.value.dx - point.dx).abs())
            .sign
            .toInt();
      } else {
        return ((p1.value.dy - point.dy).abs() - (p2.value.dy - point.dy).abs())
            .sign
            .toInt();
      }
    });

    if (pointAndIndex != null) {
      return Tuple2(data[pointAndIndex.index], pointAndIndex.value);
    }
  }
}
