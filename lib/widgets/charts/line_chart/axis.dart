import 'package:tuple/tuple.dart';

import 'range.dart';
import 'style.dart';

class LineChartAxis {
  final num? minValue;
  final num? maxValue;
  final num? tickSpan;
  final int? tickSpanCount;
  final LineChartAxisStyle style;
  final Range Function(Range range)? rangeCreator;
  final String Function(num value)? formatter;
  final List<Tuple2<num, LineChartAxisLabelStyle?>> Function()? labelStops;

  Range range(Iterable<Range> Function() lazyRanges) {
    if (minValue != null && maxValue != null) {
      return Range(minValue!, maxValue!);
    }

    final seriesRange = Range.unionRanges(lazyRanges());
    final customRange =
        rangeCreator == null ? seriesRange : rangeCreator!(seriesRange);

    return Range.intersectionRanges([
      customRange,
      if (minValue != null) Range.lowBound(minValue!),
      if (maxValue != null) Range.highBound(maxValue!),
    ]);
  }

  const LineChartAxis({
    this.minValue,
    this.maxValue,
    this.tickSpan,
    this.tickSpanCount = 4,
    this.style = const LineChartAxisStyle(),
    this.rangeCreator,
    this.formatter,
    this.labelStops,
  });

  LineChartAxis copyWith({
    num? minValue,
    num? maxValue,
    num? tickSpan,
    int? tickSpanCount,
    LineChartAxisStyle? style,
    Range Function(Range range)? rangeCreator,
    String Function(num value)? formatter,
    List<num> Function()? labelStops,
  }) {
    return LineChartAxis(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      tickSpan: tickSpan ?? this.tickSpan,
      tickSpanCount: tickSpanCount ?? this.tickSpanCount,
      style: style ?? this.style,
      rangeCreator: rangeCreator ?? this.rangeCreator,
      formatter: formatter ?? this.formatter,
    );
  }
}
