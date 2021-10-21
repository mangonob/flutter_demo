import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/dropdown_overlay.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

enum DropdownOverlayStyle {
  style1,
  style2,
  style3,
}

extension Description on DropdownOverlayStyle {
  String description() {
    switch (this) {
      case DropdownOverlayStyle.style1:
        return "Style1";
      case DropdownOverlayStyle.style2:
        return "Style2";
      case DropdownOverlayStyle.style3:
        return "Style3";
    }
  }
}

class DropdownOverlayDemo extends StatefulWidget {
  @override
  State<DropdownOverlayDemo> createState() => _DropdownOverlayDemoState();
}

class _DropdownOverlayDemoState extends State<DropdownOverlayDemo> {
  DropdownOverlayStyle _style = DropdownOverlayStyle.style1;
  bool _isVisiable = false;

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      title: "Dropdown Overlay",
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSegmentedControl(
                  groupValue: _style,
                  children: Map.fromEntries(
                    DropdownOverlayStyle.values.map((e) {
                      return MapEntry(
                        e,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.description()),
                        ),
                      );
                    }),
                  ),
                  onValueChanged: (v) {
                    setState(() {
                      _style = v as DropdownOverlayStyle;
                    });
                  },
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisiable = !_isVisiable;
                    });
                  },
                  icon: Icon(Icons.menu),
                ),
              ],
            ),
          ),
          Expanded(
            child: DropdownOverlay(
              isVisiable: _isVisiable,
              overlay: Container(
                color: Colors.green,
                child: AnimatedSize(
                  alignment: Alignment.topCenter,
                  duration: Duration(milliseconds: 250),
                  child: Container(
                    height: _style.index * 100 + 300,
                    child: Placeholder(),
                  ),
                ),
              ),
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}
