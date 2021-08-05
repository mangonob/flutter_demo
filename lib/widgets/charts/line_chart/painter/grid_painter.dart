import 'package:flutter/material.dart';

import '../area.dart';
import '../grid.dart';

class LineChartGridPainter extends CustomPainter {
  final LineChartGrid? grid;
  final Area area;

  LineChartGridPainter({
    required this.grid,
    required this.area,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    if (this.grid == null) return;

    final grid = this.grid!;
    final gridStyle = grid.style;

    if (gridStyle.backgroundColor != null) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = gridStyle.backgroundColor!,
      );
    }

    _paintGridArea(canvas, size);

    if (gridStyle.top != null) {
      final top = gridStyle.top!;
      canvas.drawLine(
        size.topLeft(Offset.zero),
        size.topRight(Offset.zero),
        Paint()
          ..strokeWidth = top.width
          ..strokeCap = StrokeCap.square
          ..color = top.color,
      );
    }

    if (gridStyle.right != null) {
      final right = gridStyle.right!;
      canvas.drawLine(
        size.topRight(Offset.zero),
        size.bottomRight(Offset.zero),
        Paint()
          ..strokeWidth = right.width
          ..strokeCap = StrokeCap.square
          ..color = right.color,
      );
    }

    if (gridStyle.bottom != null) {
      final bottom = gridStyle.bottom!;
      canvas.drawLine(
        size.bottomLeft(Offset.zero),
        size.bottomRight(Offset.zero),
        Paint()
          ..strokeWidth = bottom.width
          ..color = bottom.color,
      );
    }

    if (gridStyle.left != null) {
      final left = gridStyle.left!;
      canvas.drawLine(
        size.topLeft(Offset.zero),
        size.bottomLeft(Offset.zero),
        Paint()
          ..strokeWidth = left.width
          ..color = left.color,
      );
    }
  }

  _paintGridArea(Canvas canvas, Size size) {
    assert(this.grid != null);
    final grid = this.grid!;
    if (grid.areaColors == null) return;
    final gridColors = grid.areaColors!;

    final hCount = grid.horizontalSpan != null
        ? (area.width / grid.horizontalSpan!).ceil()
        : grid.horizontalSpanCount ?? 0;
    final hSpan = grid.horizontalSpan != null
        ? grid.horizontalSpan!
        : size.width / hCount;

    final vCount = grid.verticalSpan != null
        ? (size.width / grid.verticalSpan!).ceil()
        : grid.verticalSpanCount ?? 0;
    final vSpan =
        grid.verticalSpan != null ? grid.verticalSpan! : size.height / vCount;

    if (vCount.isFinite && vCount > 0 && hCount.isFinite && hCount > 0) {
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
      canvas.translate(0, size.height);
      canvas.scale(1, -1);

      for (final i in List.generate(vCount, (i) => i)) {
        for (final j in List.generate(hCount, (j) => j)) {
          final color = gridColors(i, j);
          canvas.drawRect(
            Rect.fromLTWH((j * hSpan).toDouble(), (i * vSpan).toDouble(),
                hSpan.toDouble(), vSpan.toDouble()),
            Paint()..color = color,
          );
        }
      }

      for (final i in List.generate(vCount, (i) => i)) {
        if (i > 0) {
          final vlStyle = grid.style.verticalLine;
          canvas.drawLine(
            Offset(0, (i * vSpan).toDouble()),
            Offset(
              size.width,
              (i * vSpan).toDouble(),
            ),
            Paint()
              ..strokeWidth = vlStyle.width
              ..color = vlStyle.color,
          );
        }
      }

      for (final j in List.generate(hCount, (j) => j)) {
        if (j > 0) {
          final hlStyle = grid.style.horizontalLine;
          canvas.drawLine(
            Offset((j * hSpan).toDouble(), 0),
            Offset(
              (j * hSpan).toDouble(),
              size.width,
            ),
            Paint()
              ..strokeWidth = hlStyle.width
              ..color = hlStyle.color,
          );
        }
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
