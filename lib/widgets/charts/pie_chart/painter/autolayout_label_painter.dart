import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import '../serie.dart';

class AutoLayoutLabelPainter extends CustomPainter {
  final List<PieChartSerie> series;
  final bool isAuxiliaryHidden;

  AutoLayoutLabelPainter({
    required this.series,
    this.isAuxiliaryHidden = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) return;

    final radius = max(series.map((s) {
      final style = s.style;
      return style.outerRadius! +
          style.leadingLineDistance! +
          style.leadingLineLength!;
    }))!;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    if (!isAuxiliaryHidden)
      canvas.drawOval(
          Rect.fromLTRB(-radius, -radius, radius, radius),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.red.withAlpha(128));

    final entries = series.fold(
        <_LabelLayoutEntry>[],
        (entries, serie) => [
              ...entries as List<_LabelLayoutEntry>,
              ..._serieEntries(serie, radius)
            ]);
    final sides = _splitSide(entries);

    if (!isAuxiliaryHidden) {
      entries.forEach((e) => e.paintDebugBorder(canvas));
    }

    final left = _layout(sides.first);
    final right = _layout(sides.last);
    left.forEach((e) => e.paint(canvas));
    right.forEach((e) => e.paint(canvas));
    canvas.restore();
  }

  List<_LabelLayoutEntry> _serieEntries(PieChartSerie serie, num radius) {
    final formatter = serie.labelFormatter;
    final labelsText = formatter != null
        ? serie.values.map((v) => formatter(v))
        : serie.values.map((v) => (v * 100).toStringAsFixed(1) + "%");

    return zip([serie.sectorRanges() as Iterable<dynamic>, labelsText])
        .map((pair) {
      final style = serie.style;
      final sectorRange = pair.first as List<num>;
      final from = sectorRange.first;
      final to = sectorRange.last;
      final labelText = pair.last;
      final entry = _LabelLayoutEntry();
      entry.theta = (from + to) / 2;
      entry.radius = radius;
      entry.padding = style.labelPadding!;
      entry.lineLength = style.labelLineLength!;
      entry.debugLabel = (serie.debugLabel ?? "<serie>") + " " + labelText;
      entry.painter = TextPainter(
          text: TextSpan(text: labelText, style: style.labelStyle),
          textDirection: TextDirection.ltr)
        ..layout();
      return entry;
    }).toList();
  }

  List<List<_LabelLayoutEntry>> _splitSide(List<_LabelLayoutEntry> entries) {
    final left = entries.where((e) => !e.isRightSide).toList()..sort();
    final right = entries.where((e) => e.isRightSide).toList()..sort();
    return [left, right];
  }

  List<_LabelLayoutEntry> _layout(List<_LabelLayoutEntry> entries) {
    final copied = entries.map((e) => e.copyWith()).toList();
    final bounds = _Bounds();
    copied.forEach((e) => bounds.bound(e));
    return copied;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _LabelLayoutEntry implements Comparable {
  String? debugLabel;
  TextPainter? painter;
  num? theta;
  EdgeInsets? padding;
  double? lineLength;
  num? radius;

  bool get isRightSide => cos(theta!) >= 0;

  Size get extendSize => Size(
        painter!.size.width + padding!.left + padding!.right,
        painter!.size.height + padding!.top + padding!.bottom,
      );

  Offset get anchor => Offset(radius! * cos(theta!), radius! * sin(theta!));

  Rect get innerRect {
    if (isRightSide) {
      return Rect.fromLTWH(
        anchor.dx,
        anchor.dy - extendSize.height / 2,
        extendSize.width,
        extendSize.height,
      );
    } else {
      return Rect.fromLTWH(
        anchor.dx - extendSize.width,
        anchor.dy - extendSize.height / 2,
        extendSize.width,
        extendSize.height,
      );
    }
  }

  void paint(Canvas canvas) {
    painter!.paint(canvas, outerRect.topLeft);
  }

  void paintDebugBorder(Canvas canvas) {
    canvas.drawRect(
      outerRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.blue.withAlpha(128),
    );
  }

  Rect get outerRect => Rect.fromLTRB(
        innerRect.left + padding!.left,
        innerRect.top + padding!.top,
        innerRect.right - padding!.right,
        innerRect.bottom - padding!.bottom,
      ).translate(isRightSide ? lineLength! : -lineLength!, 0);

  _LabelLayoutEntry({
    this.debugLabel,
    this.painter,
    this.theta,
    this.padding,
    this.lineLength,
    this.radius,
  });

  _LabelLayoutEntry copyWith({
    String? debugLabel,
    TextPainter? painter,
    num? theta,
    EdgeInsets? padding,
    double? lineLength,
    num? radius,
  }) =>
      _LabelLayoutEntry(
        debugLabel: debugLabel ?? this.debugLabel,
        painter: painter ?? this.painter,
        theta: theta ?? this.theta,
        padding: padding ?? this.padding,
        lineLength: lineLength ?? this.lineLength,
        radius: radius ?? this.radius,
      );

  @override
  int compareTo(other) {
    return cos(theta!).abs().compareTo(cos(other.theta!).abs());
  }
}

class _Bounds {
  _LabelLayoutEntry? _lower;
  _LabelLayoutEntry? _upper;

  bound(_LabelLayoutEntry entry) {
    if (_lower != null) {
      final delta = _lower!.innerRect.bottom - entry.innerRect.top;

      if (delta > 0) {
        final newTheta = asin((entry.anchor.dy + delta) / entry.radius!);
        if (newTheta.isFinite && !newTheta.isNaN) {
          entry.theta = entry.isRightSide ? newTheta : pi - newTheta;
        }
        _lower = entry;
        return;
      }
    }

    if (_upper != null) {
      final delta = entry.innerRect.bottom - _upper!.innerRect.top;
      if (delta > 0) {
        final newTheta = asin((entry.anchor.dy - delta) / entry.radius!);
        if (newTheta.isFinite && !newTheta.isNaN) {
          entry.theta = entry.isRightSide ? newTheta : pi - newTheta;
        }
        _upper = entry;
        return;
      }
    }

    if (entry.anchor.dy < 0) {
      _lower = entry;
    } else {
      _upper = entry;
    }
  }
}
