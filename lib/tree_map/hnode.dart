import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'tree_map_config.dart';
import 'node_frame.dart';
import 'tree_node.dart';

class HNode extends TreeNode {
  HNode({
    Key? key,
    required List<TreeNode> children,
    double? space,
    num? forceValue,
  }) : super(
          key: key,
          children: children,
          space: space,
          value: forceValue,
        );

  @override
  Widget build(BuildContext context) {
    final space = this.space ?? TreeMapConfig.of(context).space;
    final nodes = children!.where((c) => c.treeValue != 0).toList();
    final totalValue = nodes.map((e) => e.treeValue).sum;
    final frame = NodeFrame.of(context).frame;

    final List<Widget> childs = [];
    double currentOffset = 0;
    for (var i = 0; i < nodes.length; ++i) {
      final node = nodes[i];
      final width = (frame.width - space * (nodes.length - 1)) *
          node.treeValue /
          totalValue;

      childs.add(
        NodeFrame(
          frame: Rect.fromLTWH(
            frame.left + currentOffset,
            frame.top,
            width,
            frame.height,
          ),
          child: node,
        ),
      );

      currentOffset += width + space;
    }
    return Stack(
      children: childs,
    );
  }
}
