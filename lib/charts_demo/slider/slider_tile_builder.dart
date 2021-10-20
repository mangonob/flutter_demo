import 'package:flutter/material.dart';

class SliderTileBuilder extends StatelessWidget {
  List<Widget>? slivers;

  Widget Function(BuildContext context, Widget? scrollview) builder;

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
  List<Widget>? slivers;

  _SliderScrollView({
    Key? key,
    required this.slivers,
  }) : super(key: key);

  @override
  State<_SliderScrollView> createState() => _SliderScrollViewState();
}

class _SliderScrollViewState extends State<_SliderScrollView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (noti) {
        return false;
      },
      child: CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        slivers: widget.slivers!,
      ),
    );
  }
}
