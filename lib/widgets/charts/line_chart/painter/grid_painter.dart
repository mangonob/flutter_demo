import 'package:flutter/material.dart';

import '../area.dart';
import '../grid.dart';

class LineChartGridPainter extends CustomPainter {
  final LineChartGrid? grid;
  final Area area;
  final EdgeInsets padding;

  LineChartGridPainter({
    required this.grid,
    required this.area,
    required this.padding,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(padding.left, padding.top);
    _paintGrid(
      canvas,
      Size(
        size.width - padding.left - padding.right,
        size.height - padding.top - padding.bottom,
      ),
    );
    canvas.restore();
  }

  _paintGrid(Canvas canvas, Size size) {
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

    if (gridStyle.decoration != null) {
      gridStyle.decoration!.createBoxPainter().paint(
            canvas,
            Offset.zero,
            ImageConfiguration(size: size),
          );
    }
  }

  _paintGridArea(Canvas canvas, Size size) {
    assert(this.grid != null);
    final grid = this.grid!;
    final gridColors = grid.areaColors;

    final hCount = grid.horizontalSpan != null
        ? (size.width / grid.horizontalSpan!).ceil()
        : grid.horizontalSpanCount ?? 1;
    final hSpan = grid.horizontalSpan != null
        ? grid.horizontalSpan!
        : size.width / hCount;

    final vCount = grid.verticalSpan != null
        ? (size.height / grid.verticalSpan!).ceil()
        : grid.verticalSpanCount ?? 1;
    final vSpan =
        grid.verticalSpan != null ? grid.verticalSpan! : size.height / vCount;

    if (vCount.isFinite && vCount > 0 && hCount.isFinite && hCount > 0) {
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
      canvas.translate(0, size.height);
      canvas.scale(1, -1);

      if (gridColors != null) {
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
      }

      if (grid.style.verticalLine != null) {
        for (final i in List.generate(vCount, (i) => i)) {
          if (i > 0) {
            final vlStyle = grid.style.verticalLine!;
            canvas.drawLine(
              Offset(0, (i * vSpan).toDouble()),
              Offset(
                size.width,
                (i * vSpan).toDouble(),
              ),
              Paint()
                ..strokeWidth = vlStyle.width!
                ..color = vlStyle.color!,
            );
          }
        }
      }

      if (grid.style.horizontalLine != null) {
        for (final j in List.generate(hCount, (j) => j)) {
          if (j > 0) {
            final hlStyle = grid.style.horizontalLine!;
            canvas.drawLine(
              Offset((j * hSpan).toDouble(), 0),
              Offset(
                (j * hSpan).toDouble(),
                size.height,
              ),
              Paint()
                ..strokeWidth = hlStyle.width!
                ..color = hlStyle.color!,
            );
          }
        }
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
