import 'dart:ui';

import 'package:flutter/material.dart';

import 'style.dart';

class LineChartGrid {
  final LineChartGridStyle style;
  final int? verticalSpanCount;
  final int? horizontalSpanCount;
  final num? verticalSpan;
  final num? horizontalSpan;
  final Color Function(int x, int y)? areaColors;

  const LineChartGrid({
    this.style = const LineChartGridStyle(),
    this.verticalSpanCount,
    this.horizontalSpanCount,
    this.verticalSpan,
    this.horizontalSpan,
    this.areaColors,
  });

  LineChartGrid copyWith({
    LineChartGridStyle? style,
    int? verticalSpanCount,
    int? horizontalSpanCount,
    num? verticalSpan,
    num? horizontalSpan,
    Color Function(int x, int y)? areaColors,
  }) {
    return LineChartGrid(
      style: style ?? this.style,
      verticalSpanCount: verticalSpanCount ?? this.verticalSpanCount,
      horizontalSpanCount: horizontalSpanCount ?? this.horizontalSpanCount,
      verticalSpan: verticalSpan ?? this.verticalSpan,
      horizontalSpan: horizontalSpan ?? this.horizontalSpan,
      areaColors: areaColors ?? this.areaColors,
    );
  }
}
