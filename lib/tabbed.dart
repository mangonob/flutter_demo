import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/logo_example.dart';
import 'package:flutter_demo/painter-example.dart';
import 'package:flutter_demo/playground.dart';

class Tabbed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabbedState();
}

class TabbedState extends State<Tabbed> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              children: [
                Playground(),
                PainterExample(),
                LogoExample(),
              ],
              index: _tabController.index,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(0x2F),
                  blurRadius: 3,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              child: Container(
                height: 49,
                child: TabBar(
                  controller: _tabController,
                  onTap: (i) => setState(() => _selectedIndex = i),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Icon(
                      _selectedIndex == 0 ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    ),
                    Icon(
                      _selectedIndex == 1
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.orange,
                    ),
                    Icon(
                      _selectedIndex == 2 ? Icons.person : Icons.person_outline,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
