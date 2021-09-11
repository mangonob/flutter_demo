import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class AnimatedIconDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: GridView.extent(
        maxCrossAxisExtent: 80,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          _Icon(icon: AnimatedIcons.add_event),
          _Icon(icon: AnimatedIcons.arrow_menu),
          _Icon(icon: AnimatedIcons.close_menu),
          _Icon(icon: AnimatedIcons.ellipsis_search),
          _Icon(icon: AnimatedIcons.home_menu),
          _Icon(icon: AnimatedIcons.list_view),
          _Icon(icon: AnimatedIcons.pause_play),
        ],
      ),
    );
  }
}

class _Icon extends StatefulWidget {
  final AnimatedIconData icon;

  _Icon({
    required this.icon,
  });

  @override
  __IconState createState() => __IconState();
}

class __IconState extends State<_Icon> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isInBegin = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isInBegin ? _controller.forward() : _controller.reverse();
        _isInBegin = !_isInBegin;
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, child) {
            return AnimatedIcon(
              icon: widget.icon,
              color: Colors.orange,
              size: 40,
              progress: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
            );
          },
        ),
      ),
    );
  }
}
