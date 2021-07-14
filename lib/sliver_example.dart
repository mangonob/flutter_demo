import 'package:flutter/material.dart';

class SliverExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Text("Title"),
            toolbarHeight: 44,
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListTile(
                onTap: () {},
                title: Text('Item #$index'),
              ),
              // Builds 1000 ListTiles
              childCount: 10,
            ),
          ),
          SliverPersistentHeader(
            delegate: MyHeader(),
            pinned: true,
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListTile(
                onTap: () {},
                title: Text('Item #$index'),
              ),
              // Builds 1000 ListTiles
              childCount: 42,
            ),
          ),
        ],
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
