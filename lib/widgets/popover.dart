import 'package:flutter/material.dart';
import 'package:flutter_demo/popover_overlay/popover_overlay.dart';
import 'package:flutter_demo/popover_overlay/show_popover_overlay.dart';

/// 气泡弹窗
/// Widget child 宿主组件，该组件会被直接渲染，点击时显示气泡
/// Widget popover 气泡组件
/// EdgeInsets padding 气泡组件的外边距
class Popover extends StatelessWidget {
  final Widget child;
  final PopoverBuilder popoverBuilder;
  final EdgeInsets padding;
  Popover({
    Key? key,
    required this.child,
    required this.popoverBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopoverOverlay(
          context,
          popoverBuilder: popoverBuilder,
        );
      },
      child: child,
    );
  }
}
