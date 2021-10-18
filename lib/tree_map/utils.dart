extension TreeMapIterableExtension on Iterable {
  /// 向数组中间隔插入元素
  Iterable<T> intersperse<T>(T element) {
    if (length <= 1) {
      return this as Iterable<T>;
    } else {
      return [
        ...[this.first, element],
        ...this.skip(1).toList().intersperse(element)
      ];
    }
  }
}
