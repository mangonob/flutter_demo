import 'package:flutter/material.dart';

import '../area.dart';
import '../serie.dart';
import 'serie_painter.dart';

class SeriePaint extends StatefulWidget {
  final LineChartSerie serie;
  final Area area;
  final EdgeInsets padding;
  final Widget child;
  final Offset? activePosition;

  SeriePaint({
    required this.serie,
    required this.area,
    required this.padding,
    required this.child,
    this.activePosition,
  }) : super();

  @override
  _SeriePaintState createState() => _SeriePaintState();
}

class _SeriePaintState extends State<SeriePaint> {
  @override
  void didUpdateWidget(covariant SeriePaint oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.activePosition != widget.activePosition) {
      Future.delayed(Duration.zero, () => _positionUpdated());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartSeriesPainter(
        serie: widget.serie,
        area: widget.area,
        padding: widget.padding,
      ),
      child: widget.child,
    );
  }

  _positionUpdated() {
    final boxSize = (context.findRenderObject() as RenderBox?)?.size;
    if (boxSize == null) return;
    if (widget.activePosition == null) return;
    final position = widget.activePosition!;
    final padding = widget.padding;
    final size = Size(
      boxSize.width - padding.left - padding.right,
      boxSize.height - padding.top - padding.bottom,
    );
    final localPosition = position.translate(-padding.left, -padding.top);
    final point =
        widget.area.convertPointFromGrid(localPosition, gridSize: size);
    final nearst = widget.serie.nearest(point: point, inHorizontal: true);

    if (nearst != null) {
      if (widget.serie.onActived != null) {
        final onActived = widget.serie.onActived!;
        onActived(nearst.item1);
      }
    } else {
      if (widget.serie.onDeactived != null) {
        widget.serie.onDeactived!();
      }
    }
  }
}
