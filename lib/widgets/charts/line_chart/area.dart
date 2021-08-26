import 'dart:ui';

import 'range.dart';

class Area {
  final Range _xRange;
  final Range _yRange;

  const Area(this._xRange, this._yRange);

  num get width => _xRange.length;
  num get height => _yRange.length;

  num get minX => _xRange.low;
  num get maxX => _xRange.high;
  num get minY => _yRange.low;
  num get maxY => _yRange.high;

  @override
  bool operator ==(other) {
    return other is Area &&
        _xRange == other._xRange &&
        _yRange == other._yRange;
  }

  @override
  int get hashCode => hashValues(_xRange, _yRange);

  Offset convertPointFromGrid(Offset point, {required Size gridSize}) {
    final hUnit = width / gridSize.width;
    final vUnit = height / gridSize.height;
    return Offset(point.dx * hUnit, (gridSize.height - point.dy) * vUnit);
  }

  Offset convertPointToGird(Offset point, {required Size gridSize}) {
    final hUnit = width / gridSize.width;
    final vUnit = height / gridSize.height;
    return Offset(
      (point.dx - minX) / hUnit,
      gridSize.height - (point.dy - minY) / vUnit,
    );
  }
}
