import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class SliverExample extends StatefulWidget {
  @override
  _SliverExampleState createState() => _SliverExampleState();
}

class _SliverExampleState extends State<SliverExample>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text(
          "Title",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ExtendedNestedScrollView(
          physics: BouncingScrollPhysics(),
          onlyOneScrollInBody: false,
          headerSliverBuilder: (ctx, _) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  color: Colors.green,
                ),
              ),
              SliverAppBar(
                title: Text("Some"),
                // expandedHeight: 100,
                collapsedHeight: 100,
                toolbarHeight: 44,
                floating: true,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  color: Colors.green,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 80,
                  color: Colors.orange,
                ),
              ),
              SliverPersistentHeader(
                delegate: MyHeader(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _SomeListView(),
              Center(child: Text("A")),
              Center(child: Text("A")),
              // _SomeListView(),
              // _SomeListView(),
              // _SomeListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SomeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        40,
        (index) => ListTile(title: Text("Item $index")),
      ),
    );
  }
}

class MyHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
      child: ListTile(
        title: SizedBox(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;
}
