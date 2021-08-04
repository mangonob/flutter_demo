import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/popover.dart';

class SomeStuff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(100, (index) {
          return ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: SizedBox()),
                Popover(
                  popover: Container(
                    width: 100,
                    height: 200,
                    color: Colors.green,
                  ),
                  child: Text("Popover $index"),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          );
        }),
      ),
    );
  }
}
