import 'package:flutter/material.dart';

class LineStyle {
  final Color? color;
  final double? width;

  const LineStyle({
    this.color = Colors.black,
    this.width = 1,
  });

  LineStyle copyWith({
    Color? color,
    double? width,
  }) =>
      LineStyle(
        color: color ?? this.color,
        width: width ?? this.width,
      );

  LineStyle merge(LineStyle? other) {
    if (other == null) return this;

    return other.copyWith(
      color: other.color,
      width: other.width,
    );
  }
}

class LineChartAxisLabelStyle {
  final TextStyle textStyle;
  final Alignment alignment;
  final EdgeInsets padding;

  const LineChartAxisLabelStyle({
    this.textStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
    this.alignment = Alignment.bottomCenter,
    this.padding = const EdgeInsets.all(2),
  });

  LineChartAxisLabelStyle copyWith({
    TextStyle? textStyle,
    Alignment? alignment,
    EdgeInsets? padding,
  }) {
    return LineChartAxisLabelStyle(
      textStyle: textStyle ?? this.textStyle,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
    );
  }

  LineChartAxisLabelStyle merge(LineChartAxisLabelStyle? other) {
    if (other == null) return this;
    return this.copyWith(
      textStyle: other.textStyle,
      alignment: other.alignment,
      padding: other.padding,
    );
  }
}

enum IndicatorMainAxis {
  /// Find nearest point in hroizontal
  horizontal,

  /// Find nearest point in vertical.
  vertical,

  /// Indicator position with interactive.
  none,
}

class LineChartIndicatorLabelStyle {
  final Alignment? alignment;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final TextStyle? style;

  const LineChartIndicatorLabelStyle({
    this.alignment,
    this.decoration,
    this.padding,
    this.style,
  });

  LineChartIndicatorLabelStyle copyWith({
    Alignment? alignment,
    Decoration? decoration,
    EdgeInsets? padding,
    TextStyle? style,
  }) =>
      LineChartIndicatorLabelStyle(
        alignment: alignment ?? this.alignment,
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        style: style ?? this.style,
      );

  LineChartIndicatorLabelStyle merge(LineChartIndicatorLabelStyle? other) {
    if (other == null) return this;

    return this.copyWith(
      alignment: other.alignment,
      decoration: other.decoration,
      padding: other.padding,
      style: other.style,
    );
  }
}

class LineChartStyle {
  final LineStyle? verticalIndicatorLine;
  final LineStyle? horizontalIndicatorLine;
  final IndicatorMainAxis indicatorMainAxis;
  final LineChartIndicatorLabelStyle? topLabel;
  final LineChartIndicatorLabelStyle? bottomLabel;
  final LineChartIndicatorLabelStyle? leftLabel;
  final LineChartIndicatorLabelStyle? rightLabel;
  final Decoration? indicator;
  final Size? indicatorSize;

  const LineChartStyle({
    this.verticalIndicatorLine = const LineStyle(color: Colors.grey),
    this.horizontalIndicatorLine = const LineStyle(color: Colors.grey),
    this.indicatorMainAxis = IndicatorMainAxis.vertical,
    this.topLabel,
    this.bottomLabel,
    this.leftLabel,
    this.rightLabel,
    this.indicator,
    this.indicatorSize,
  });

  LineChartStyle copyWith({
    LineStyle? verticalIndicatorLine,
    LineStyle? horizontalIndicatorLine,
    IndicatorMainAxis? indicatorMainAxis,
    LineChartIndicatorLabelStyle? topLabel,
    LineChartIndicatorLabelStyle? bottomLabel,
    LineChartIndicatorLabelStyle? leftLabel,
    LineChartIndicatorLabelStyle? rightLabel,
    Decoration? indicator,
    Size? indicatorSize,
  }) {
    return LineChartStyle(
      verticalIndicatorLine:
          verticalIndicatorLine ?? this.verticalIndicatorLine,
      horizontalIndicatorLine:
          horizontalIndicatorLine ?? this.horizontalIndicatorLine,
      indicatorMainAxis: indicatorMainAxis ?? this.indicatorMainAxis,
      topLabel: topLabel ?? this.topLabel,
      bottomLabel: bottomLabel ?? this.bottomLabel,
      leftLabel: leftLabel ?? this.leftLabel,
      rightLabel: rightLabel ?? this.rightLabel,
      indicator: indicator ?? this.indicator,
      indicatorSize: indicatorSize ?? this.indicatorSize,
    );
  }

  LineChartStyle merge(LineChartStyle? other) {
    if (other == null) return this;

    return this.copyWith(
      verticalIndicatorLine: other.verticalIndicatorLine,
      horizontalIndicatorLine: other.horizontalIndicatorLine,
      indicatorMainAxis: other.indicatorMainAxis,
      topLabel: other.topLabel,
      bottomLabel: other.bottomLabel,
      leftLabel: other.leftLabel,
      rightLabel: other.rightLabel,
      indicator: other.indicator,
      indicatorSize: other.indicatorSize,
    );
  }
}

class LineChartGridStyle {
  final LineStyle? verticalLine;
  final LineStyle? horizontalLine;
  final Decoration? decoration;
  final Color? backgroundColor;

  const LineChartGridStyle({
    this.verticalLine,
    this.horizontalLine,
    this.decoration,
    this.backgroundColor = Colors.white,
  });

  LineChartGridStyle copyWith({
    LineStyle? verticalLine,
    LineStyle? horizontalLine,
    Decoration? decoration,
    Color? backgroundColor,
  }) {
    return LineChartGridStyle(
      verticalLine: verticalLine ?? this.verticalLine,
      horizontalLine: horizontalLine ?? this.horizontalLine,
      decoration: decoration ?? this.decoration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  LineChartGridStyle merge(LineChartGridStyle? other) {
    if (other == null) return this;

    return this.copyWith(
      verticalLine: other.verticalLine,
      horizontalLine: other.horizontalLine,
      decoration: other.decoration,
      backgroundColor: other.backgroundColor,
    );
  }
}

class LineChartAxisStyle {
  final LineStyle lineStyle;
  final LineStyle tickStyle;
  final LineChartAxisLabelStyle labelStyle;
  final bool hasTick;
  final bool hasLabel;
  final double tickSize;

  const LineChartAxisStyle({
    this.lineStyle = const LineStyle(),
    this.tickStyle = const LineStyle(),
    this.labelStyle = const LineChartAxisLabelStyle(),
    this.hasTick = true,
    this.hasLabel = true,
    this.tickSize = 8,
  });

  LineChartAxisStyle copyWith({
    LineStyle? lineStyle,
    LineStyle? tickStyle,
    LineChartAxisLabelStyle? labelStyle,
    bool? hasTick,
    bool? hasLabel,
    double? tickSize,
  }) {
    return LineChartAxisStyle(
      lineStyle: lineStyle ?? this.lineStyle,
      tickStyle: tickStyle ?? this.tickStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hasTick: hasTick ?? this.hasTick,
      hasLabel: hasLabel ?? this.hasLabel,
      tickSize: tickSize ?? this.tickSize,
    );
  }

  LineChartAxisStyle merge(LineChartAxisStyle? other) {
    if (other == null) return this;

    return this.copyWith(
      lineStyle: other.lineStyle,
      tickStyle: other.tickStyle,
      labelStyle: other.labelStyle,
      hasTick: other.hasTick,
      hasLabel: other.hasLabel,
      tickSize: other.tickSize,
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

  LineChartSerieStyle merge(LineChartSerieStyle? other) {
    if (other == null) return this;

    return this.copyWith(
      lineStyle: other.lineStyle,
      strokeCap: other.strokeCap,
      strokeJoin: other.strokeJoin,
      decoration: other.decoration,
      decorationSize: other.decorationSize,
    );
  }
}
