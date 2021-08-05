import 'package:flutter/material.dart';

class LineStyle {
  final Color color;
  final double width;

  const LineStyle({
    this.color = Colors.black,
    this.width = 1,
  });
}

enum IndicatorMainAxis {
  horzontal,
  vertical,
}

class LineChartStyle {
  final LineStyle? verticalIndicatorLine;
  final LineStyle? horizontalIndicatorLine;
  final IndicatorMainAxis indicaotrMainAxis;
  final Decoration? indicator;
  final Size? indicatorSize;

  const LineChartStyle({
    this.verticalIndicatorLine = const LineStyle(color: Colors.red),
    this.horizontalIndicatorLine = const LineStyle(color: Colors.green),
    this.indicaotrMainAxis = IndicatorMainAxis.horzontal,
    this.indicator,
    this.indicatorSize,
  });

  LineChartStyle copyWith({
    LineStyle? verticalIndicatorLine,
    LineStyle? horizontalIndicatorLine,
    IndicatorMainAxis? indicaotrMainAxis,
    Decoration? indicator,
    Size? indicatorSize,
  }) {
    return LineChartStyle(
      verticalIndicatorLine:
          verticalIndicatorLine ?? this.verticalIndicatorLine,
      horizontalIndicatorLine:
          horizontalIndicatorLine ?? this.horizontalIndicatorLine,
      indicaotrMainAxis: indicaotrMainAxis ?? this.indicaotrMainAxis,
      indicator: indicator ?? this.indicator,
      indicatorSize: indicatorSize ?? this.indicatorSize,
    );
  }
}

class LineChartGridStyle {
  final LineStyle verticalLine;
  final LineStyle horizontalLine;
  final LineStyle? top;
  final LineStyle? right;
  final LineStyle? left;
  final LineStyle? bottom;
  final Color? backgroundColor;

  const LineChartGridStyle({
    this.verticalLine = const LineStyle(color: Colors.grey),
    this.horizontalLine = const LineStyle(color: Colors.grey),
    this.top,
    this.right,
    this.left,
    this.bottom,
    this.backgroundColor = Colors.white,
  });

  LineChartGridStyle copyWith({
    LineStyle? verticalLine,
    LineStyle? horizontalLine,
    LineStyle? top,
    LineStyle? right,
    LineStyle? left,
    LineStyle? bottom,
    Color? backgroundColor,
  }) {
    return LineChartGridStyle(
      verticalLine: verticalLine ?? this.verticalLine,
      horizontalLine: horizontalLine ?? this.horizontalLine,
      top: top ?? this.top,
      right: right ?? this.right,
      left: left ?? this.left,
      bottom: bottom ?? this.bottom,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

class LineChartAxisStyle {
  final LineStyle lineStyle;
  final LineStyle tickStyle;
  final TextStyle? labelStyle;
  final EdgeInsets labelPadding;
  final bool hasTick;
  final double tickSize;
  final Alignment labelAlignment;
  final Alignment? firstLabelAlignment;
  final Alignment? lastLabelAlignment;

  const LineChartAxisStyle({
    this.lineStyle = const LineStyle(),
    this.tickStyle = const LineStyle(),
    this.labelStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
    this.labelPadding = const EdgeInsets.all(2),
    this.hasTick = true,
    this.tickSize = 8,
    this.labelAlignment = Alignment.bottomRight,
    this.firstLabelAlignment,
    this.lastLabelAlignment,
  });

  LineChartAxisStyle copyWith({
    LineStyle? lineStyle,
    LineStyle? tickStyle,
    TextStyle? labelStyle,
    EdgeInsets? labelPadding,
    bool? hasTick,
    double? tickSize,
    Alignment? labelAlignment,
    Alignment? firstLabelAlignment,
    Alignment? lastLabelAlignment,
  }) {
    return LineChartAxisStyle(
      lineStyle: lineStyle ?? this.lineStyle,
      tickStyle: tickStyle ?? this.tickStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      labelPadding: labelPadding ?? this.labelPadding,
      hasTick: hasTick ?? this.hasTick,
      tickSize: tickSize ?? this.tickSize,
      labelAlignment: labelAlignment ?? this.labelAlignment,
      firstLabelAlignment: firstLabelAlignment ?? this.firstLabelAlignment,
      lastLabelAlignment: lastLabelAlignment ?? this.lastLabelAlignment,
    );
  }
}

class LineChartSerieStyle {
  final LineStyle lineStyle;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final Decoration? decoration;
  final Size? decorationSize;

  const LineChartSerieStyle({
    this.lineStyle = const LineStyle(),
    this.strokeCap = StrokeCap.round,
    this.strokeJoin = StrokeJoin.round,
    this.decoration,
    this.decorationSize,
  });

  LineChartSerieStyle copyWith({
    LineStyle? lineStyle,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    Decoration? decoration,
    Size? decorationSize,
  }) {
    return LineChartSerieStyle(
      lineStyle: lineStyle ?? this.lineStyle,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      decoration: decoration ?? this.decoration,
      decorationSize: decorationSize ?? this.decorationSize,
    );
  }
}
