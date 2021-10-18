import 'package:flutter/widgets.dart';

import 'node_frame.dart';
import 'tree_map_config.dart';
import 'tree_node.dart';

class LeafNode extends TreeNode {
  LeafNode({
    Key? key,
    required Widget child,
    required num value,
  }) : super(key: key, child: child, value: value);

  @override
  Widget build(BuildContext context) {
    final duration = TreeMapConfig.of(context).duration;
    final frame = NodeFrame.of(context).frame;
    return AnimatedContainer(
      duration: duration,
      margin: EdgeInsets.only(top: frame.top, left: frame.left),
      height: frame.height,
      width: frame.width,
      child: child!,
    );
  }
}
