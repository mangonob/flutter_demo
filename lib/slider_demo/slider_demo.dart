import 'package:flutter/material.dart';
import 'package:flutter_demo/slider_demo/slider_scope/slider_scope.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'slider_scope/slider_tile_builder.dart';

class SliderDemo extends StatefulWidget {
  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      title: "Slider Demo",
      body: SliderScope(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 250));
            _refreshController.refreshCompleted();
          },
          child: _buildSlider(context),
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SliderTileBuilder(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Item $index",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 42,
                    ),
                  ),
                ],
                builder: (ctx, scrollView) {
                  return Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 120,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Header $index",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (scrollView != null) Expanded(child: scrollView),
                      ],
                    ),
                  );
                },
              );
            },
            childCount: 100,
          ),
        ),
      ],
    );
  }
}
