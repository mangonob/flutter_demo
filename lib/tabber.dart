import 'package:flutter/material.dart';

class TabberContext extends InheritedWidget {
  final bool inBottom;
  final bool inTop;
  final double contentHeight;
  TabberContext({
    required Widget child,
    required this.inBottom,
    required this.inTop,
    required this.contentHeight,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant TabberContext oldWidget) {
    return inBottom != oldWidget.inBottom ||
        inTop != oldWidget.inTop ||
        contentHeight != oldWidget.contentHeight;
  }

  static TabberContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabberContext>()!;
  }
}

class Tabber extends StatefulWidget {
  final List<Widget> topSlivers;
  final double headerHeight;

  Tabber({
    Key? key,
    required this.topSlivers,
    this.headerHeight = 80,
  }) : super(key: key);

  @override
  _TabberState createState() => _TabberState();
}

class _TabberState extends State<Tabber> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isTop = false;
  bool _isBottom = false;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isBottom = true;
        _locked = true;
      });
    } else {
      setState(() {
        _isBottom = false;
        _locked = false;
      });
    }

    if (_scrollController.offset < _scrollController.position.minScrollExtent) {
      setState(() => _isTop = true);
    } else {
      setState(() => _isTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return TabberContext(
          inBottom: _isBottom,
          inTop: _isTop,
          contentHeight: constraints.maxHeight - widget.headerHeight,
          child: NotificationListener<UnlockScrollNotification>(
            onNotification: (notif) {
              setState(() {
                _locked = false;
              });
              return true;
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: _locked
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              slivers: [
                ...widget.topSlivers,
                SliverToBoxAdapter(
                  child: Container(height: 100, color: Colors.blue),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: widget.headerHeight,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: "A"),
                        Tab(text: "B"),
                        Tab(text: "C"),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: constraints.maxHeight - widget.headerHeight,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ScrollableTabWidget(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 100,
                            color: Colors.green,
                            child: Center(child: Text("Text")),
                          ),
                        ),
                        Center(child: Text("Text")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScrollableTabWidget extends StatefulWidget {
  @override
  _ScrollableTabWidgetState createState() => _ScrollableTabWidgetState();
}

class _ScrollableTabWidgetState extends State<ScrollableTabWidget> {
  late ScrollController _scrollController;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset < -100) {
      UnlockScrollNotification().dispatch(context);
      setState(() {
        _isLocked = true;
      });
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 125), curve: Curves.linear);
    }

    // if (_scrollController.offset <=
    //     _scrollController.position.minScrollExtent) {
    //   setState(() {
    //     _inTop = true;
    //   });
    // } else {
    //   setState(() {
    //     _inTop = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final tabber = TabberContext.of(context);
    if (tabber.inBottom) {
      setState(() {
        // _isLocked = false;
      });
    }

    return Container(
      height: tabber.contentHeight,
      color: Colors.red,
      child: ListView(
        controller: _scrollController,
        physics: _isLocked
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        children: List.generate(
          100,
          (index) => Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color(0xFFEEEEEE),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnlockScrollNotification extends Notification {}
