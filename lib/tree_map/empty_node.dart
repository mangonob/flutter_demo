import 'package:flutter/widgets.dart';

import 'tree_node.dart';

class EmptyNode extends TreeNode {
  EmptyNode({
    Key? key,
  }) : super(
          key: key,
          children: [],
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
