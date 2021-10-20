import 'package:flutter/material.dart';

class DropdownOverlay extends StatefulWidget {
  @override
  State<DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<DropdownOverlay> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          transitionBuilder: (child, ani) {
            return SizeTransition(
              sizeFactor: ani,
              child: FadeTransition(
                opacity: ani,
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(_isExpanded),
            alignment: Alignment.topCenter,
            height: _isExpanded ? 400 : 200,
            color: _isExpanded ? Colors.red : Colors.green,
            child: Center(
              child: Text(
                _isExpanded ? "Expanded" : "Closed",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(_isExpanded ? "Close" : "Expand"),
        ),
      ],
    );
  }
}
