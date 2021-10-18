import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

abstract class TreeNode extends StatelessWidget {
  final List<TreeNode>? children;
  final Widget? child;
  final num? value;
  final double? space;

  num get treeValue {
    if (children != null && children!.isEmpty) {
      return 0;
    } else {
      return value ?? children!.map((e) => e.treeValue).sum;
    }
  }

  TreeNode({
    Key? key,
    this.children,
    this.child,
    this.value,
    this.space,
  })  : assert((value != null && child != null) || children != null),
        super(key: key);
}
