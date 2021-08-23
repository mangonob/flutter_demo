import 'dart:math';
import 'dart:ui';

import 'package:quiver/iterables.dart';

import 'style.dart';

typedef ValueConvertor<T> = num Function(T v, int index);
typedef SerieFn<T, D> = T Function(D d, int index);

class PieChartSerie<D> {
  final List<D> data;
  final ValueConvertor<D> valueFn;
  final SerieFn<Color?, D>? colorFn;
  final SerieFn<Color?, D>? lineColorFn;
  final SerieFn<num, num>? valueFilter;
  final PieChartSerieStyle style;
  final String? Function(num)? labelFormatter;
  final bool isSkipDrawWhenEmpty;
  final String? debugLabel;

  List<num> get values {
    return enumerate(data)
        .map((entry) => valueFn(entry.value, entry.index))
        .toList();
  }

  PieChartSerie({
    required this.data,
    required this.valueFn,
    this.colorFn,
    this.lineColorFn,
    this.valueFilter,
    PieChartSerieStyle? style,
    this.labelFormatter,
    this.isSkipDrawWhenEmpty = true,
    this.debugLabel,
  }) : this.style = PieChartSerieStyle.normal().merge(style);

  List<List<num>>? sectorRanges() {
    final outerRadius = style.outerRadius!;

    final span = style.span!;
    final startAngle = style.startAngle!;
    final isClosewise = style.direction! == PieChartSerieDirection.clockwise;
    final theta = asin(span / outerRadius);
    final total = values.fold(0, (s, n) => (s as num) + n);
    final scale =
        (total * 2 * pi - values.length * theta * 2) / (total * 2 * pi);

    if (scale.isFinite && !scale.isNaN) {
      final alphas = values.map((v) => v * scale * pi * 2);
      final startAngles =
          alphas.fold(<num>[startAngle - pi / 2], (starts, alpha) {
        final _starts = starts as List<num>;
        final tail = _starts.last;
        final delta = alpha + theta * 2;
        return [...starts, isClosewise ? tail + delta : tail - delta];
      });
      final endAngles = startAngles.sublist(1);
      return zip([startAngles, endAngles]).toList();
    }
  }
}
