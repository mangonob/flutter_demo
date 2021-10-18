import 'package:flutter/material.dart';

import 'node_frame.dart';
import 'tree_map_config.dart';
import 'tree_node.dart';
import 'package:collection/collection.dart';

class VNode extends TreeNode {
  VNode({
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
      final height = (frame.height - space * (nodes.length - 1)) *
          node.treeValue /
          totalValue;

      childs.add(
        NodeFrame(
          frame: Rect.fromLTWH(
            frame.left,
            frame.top + currentOffset,
            frame.width,
            height,
          ),
          child: node,
        ),
      );

      currentOffset += height + space;
    }
    return Stack(
      children: childs,
    );
  }
}
