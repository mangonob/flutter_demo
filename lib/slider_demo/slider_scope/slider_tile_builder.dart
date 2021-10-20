import 'package:flutter/material.dart';

import 'slider_scope.dart';

class SliderTileBuilder extends StatelessWidget {
  final List<Widget>? slivers;
  final Widget Function(BuildContext context, Widget? scrollview) builder;

  SliderTileBuilder({Key? key, required this.builder, this.slivers});

  @override
  Widget build(BuildContext context) {
    if (slivers != null) {
      return builder(
        context,
        _SliderScrollView(slivers: slivers),
      );
    } else {
      return builder(context, null);
    }
  }
}

class _SliderScrollView extends StatefulWidget {
  final List<Widget>? slivers;

  _SliderScrollView({
    Key? key,
    required this.slivers,
  }) : super(key: key);

  @override
  State<_SliderScrollView> createState() => _SliderScrollViewState();
}

class _SliderScrollViewState extends State<_SliderScrollView> {
  late ScrollController _scrollController;
  ValueNotifier<double>? _offset;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(keepScrollOffset: false);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        _offset = context.findAncestorStateOfType<SliderScopeState>()?.offset;
        if (_offset != null) {
          _scrollController.jumpTo(_offset!.value);
        }
        _offset?.addListener(_offsetListener);
      }
    });
  }

  _offsetListener() {
    if (_offset != null) {
      if (_scrollController.offset != _offset!.value) {
        _scrollController.jumpTo(_offset!.value);
      }
    }
  }

  @override
  void dispose() {
    _offset?.removeListener(_offsetListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (noti) {
        if (noti.depth == 0) {
          final offset =
              context.findAncestorStateOfType<SliderScopeState>()?.offset;
          if (offset?.value != null &&
              _scrollController.offset != offset!.value) {
            offset.value = noti.metrics.pixels;
          }
        }
        return false;
      },
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        slivers: widget.slivers!,
      ),
    );
  }
}
