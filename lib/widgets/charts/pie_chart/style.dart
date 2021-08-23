import 'dart:ui';

import 'package:flutter/material.dart';

enum PieChartSerieDirection {
  clockwise,
  antiClockwise,
}

class PieChartSerieStyle {
  final double? outerRadius;
  final double? innerRadius;
  final double? startAngle;
  final PieChartSerieDirection? direction;
  final Color? color;
  final Color? emptyColor;
  final Color? lineColor;
  final double? lineWidth;
  final double? leadingLineDistance;
  final double? leadingLineLength;
  final double? labelLineLength;
  final EdgeInsets? labelPadding;
  final double? span;
  final TextStyle? labelStyle;

  const PieChartSerieStyle({
    this.outerRadius,
    this.innerRadius,
    this.startAngle,
    this.direction,
    this.color,
    this.emptyColor,
    this.lineColor,
    this.lineWidth,
    this.leadingLineDistance,
    this.leadingLineLength,
    this.labelLineLength,
    this.labelPadding,
    this.span,
    this.labelStyle,
  });

  factory PieChartSerieStyle.normal() => PieChartSerieStyle(
        outerRadius: 70,
        innerRadius: 40,
        startAngle: 0,
        direction: PieChartSerieDirection.clockwise,
        color: Colors.red,
        emptyColor: Colors.grey,
        lineColor: Colors.green,
        lineWidth: 1,
        leadingLineDistance: 2,
        leadingLineLength: 20,
        labelLineLength: 34,
        labelPadding: EdgeInsets.symmetric(horizontal: 5),
        span: 1,
        labelStyle: TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
      );

  PieChartSerieStyle copyWith({
    double? outerRadius,
    double? innerRadius,
    double? startAngle,
    PieChartSerieDirection? direction,
    Color? color,
    Color? emptyColor,
    Color? lineColor,
    double? lineWidth,
    double? leadingLineDistance,
    double? leadingLineLength,
    double? labelLineLength,
    EdgeInsets? labelPadding,
    double? span,
    TextStyle? labelStyle,
  }) =>
      PieChartSerieStyle(
        outerRadius: outerRadius ?? this.outerRadius,
        innerRadius: innerRadius ?? this.innerRadius,
        startAngle: startAngle ?? this.startAngle,
        direction: direction ?? this.direction,
        color: color ?? this.color,
        emptyColor: emptyColor ?? this.emptyColor,
        lineColor: lineColor ?? this.lineColor,
        lineWidth: lineWidth ?? this.lineWidth,
        leadingLineDistance: leadingLineDistance ?? this.leadingLineDistance,
        leadingLineLength: leadingLineLength ?? this.leadingLineLength,
        labelLineLength: labelLineLength ?? this.labelLineLength,
        labelPadding: labelPadding ?? this.labelPadding,
        span: span ?? this.span,
        labelStyle: labelStyle ?? this.labelStyle,
      );

  PieChartSerieStyle merge(PieChartSerieStyle? other) {
    if (other == null) return this;

    return copyWith(
      outerRadius: other.outerRadius,
      innerRadius: other.innerRadius,
      startAngle: other.startAngle,
      direction: other.direction,
      color: other.color,
      emptyColor: other.emptyColor,
      lineColor: other.lineColor,
      lineWidth: other.lineWidth,
      leadingLineDistance: other.leadingLineDistance,
      leadingLineLength: other.leadingLineLength,
      labelLineLength: other.labelLineLength,
      labelPadding: other.labelPadding,
      span: other.span,
      labelStyle: other.labelStyle,
    );
  }

  @override
  operator ==(Object other) =>
      other is PieChartSerieStyle &&
      other.outerRadius == outerRadius &&
      other.innerRadius == innerRadius &&
      other.startAngle == startAngle &&
      other.direction == direction &&
      other.color == color &&
      other.emptyColor == emptyColor &&
      other.lineColor == lineColor &&
      other.lineWidth == lineWidth &&
      other.leadingLineDistance == leadingLineDistance &&
      other.leadingLineLength == leadingLineLength &&
      other.labelLineLength == labelLineLength &&
      other.labelPadding == labelPadding &&
      other.span == span &&
      other.labelStyle == labelStyle;

  @override
  int get hashCode => hashValues(
        outerRadius,
        innerRadius,
        startAngle,
        direction,
        color,
        emptyColor,
        lineColor,
        lineWidth,
        leadingLineDistance,
        leadingLineLength,
        labelLineLength,
        labelPadding,
        span,
        labelStyle,
      );
}
