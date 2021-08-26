import 'dart:math';

import 'package:flutter/material.dart';

class Range {
  final num low;
  final num high;

  const Range(this.low, this.high);

  bool operator ==(other) {
    return other is Range && other.low == low && other.high == high;
  }

  @override
  int get hashCode => hashValues(low, high);

  static const none = Range(double.infinity, double.negativeInfinity);
  static const all = Range(double.negativeInfinity, double.infinity);

  Range union(Range other) {
    return Range(
      min(low, other.low),
      max(high, other.high),
    );
  }

  Range copyWith({num? low, num? high}) {
    return Range(
      low ?? this.low,
      high ?? this.high,
    );
  }

  factory Range.lowBound(num low) => Range(
        low,
        double.infinity,
      );

  factory Range.highBound(num high) => Range(
        double.negativeInfinity,
        high,
      );

  Range intersection(Range other) {
    return Range(max(low, other.low), min(high, other.high));
  }

  factory Range.unionRanges(Iterable<Range> ranges) {
    return ranges.fold(Range.none, (u1, u2) => u1.union(u2));
  }

  factory Range.intersectionRanges(Iterable<Range> ranges) {
    return ranges.fold(Range.all, (u1, u2) => u1.intersection(u2));
  }

  num get length => high - low;

  factory Range.highestBit(int offset, Range range) {
    if (range.length.isFinite && range.length.isNaN) {
      final exponent =
          (log(max(range.low.abs(), range.high.abs())) / log(10)).floor() -
              offset;
      final accuracy = pow(10, exponent);
      if (accuracy.isFinite) {
        return Range(
          (range.low / accuracy).floor() * accuracy,
          (range.high / accuracy).ceil() * accuracy,
        );
      } else {
        return range;
      }
    } else {
      return range;
    }
  }

  factory Range.inset(
    Range range, {
    num? all,
    num? low,
    num? high,
  }) {
    if (all != null) {
      return Range(range.low - all, range.high + all);
    } else {
      return Range(range.low - (low ?? 0), range.high + (high ?? 0));
    }
  }

  factory Range.centeralScale(num scale, Range range) {
    final newLength = scale * range.length;
    final distance = (newLength - range.length) / 2;
    return distance.isNaN
        ? range
        : Range(range.low - distance, range.high + distance);
  }

  factory Range.scale(num scale, Range range) {
    return Range(range.low * scale, range.high * scale);
  }
}
