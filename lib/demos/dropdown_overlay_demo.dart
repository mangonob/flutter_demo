import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/dropdown_overlay.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class DropdownOverlayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      title: "Dropdown Overlay",
      body: DropdownOverlay(),
    );
  }
}
