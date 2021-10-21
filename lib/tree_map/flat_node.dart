import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'empty_node.dart';
import 'hnode.dart';
import 'node_frame.dart';
import 'tree_node.dart';
import 'vnode.dart';

class FlatNode extends TreeNode {
  FlatNode({
    Key? key,
    required List<TreeNode> children,
  }) : super(
          key: key,
          children: children,
        );

  @override
  Widget build(BuildContext context) {
    final nodes = children!
        .where((e) => e.treeValue != 0)
        .sortedBy((e) => e.treeValue)
        .reversed
        .toList();

    if (nodes.length == 0) {
      return EmptyNode();
    } else if (nodes.length == 1) {
      return nodes.first;
    }

    final values = nodes.map((e) => e.treeValue).toList();
    final index = max(1, min(_split(values), values.length - 1));
    final left = nodes.sublist(0, index);
    final right = nodes.sublist(index);
    final frame = NodeFrame.of(context).frame;

    if (frame.width > frame.height) {
      return HNode(
        children: [
          FlatNode(children: left),
          FlatNode(children: right),
        ],
      );
    } else {
      return VNode(
        children: [
          FlatNode(children: left),
          FlatNode(children: right),
        ],
      );
    }
  }

  int _split(List<num> values) {
    final total = values.sum;
    final half = total / 2;

    num current = 0;
    int index = 0;

    for (var i = 0; i < values.length; ++i) {
      final value = values[i];
      current += value;
      if (current >= half) {
        if (current - half > value / 2) {
          index = i + 1;
          break;
        } else {
          index = i;
          break;
        }
      }
    }

    return index;
  }
}
