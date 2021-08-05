import 'dart:math';

class Range {
  final num low;
  final num high;

  const Range(this.low, this.high);

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
        double.negativeInfinity,
      );

  factory Range.highBound(num high) => Range(
        double.infinity,
        high,
      );

  Range intersection(Range other) {
    return Range(max(low, other.low), min(high, other.high));
  }

  static Range unionRanges(Iterable<Range> ranges) {
    return ranges.fold(Range.none, (u1, u2) => u1.union(u2));
  }

  static Range intersectionRanges(Iterable<Range> ranges) {
    return ranges.fold(Range.all, (u1, u2) => u1.intersection(u2));
  }

  num get length => high - low;
}
