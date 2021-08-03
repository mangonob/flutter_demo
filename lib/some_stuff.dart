import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/popover.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SomeStuff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => Others()),
              );
            },
            child: Text("Push"),
          ),
        ),
      ),
    );
  }
}

class Others extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: FlutterEasyLoading(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Container(
            color: Colors.white,
            child: Scaffold(
              body: GestureDetector(
                onDoubleTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        onChanged: (v) {},
                        items: [
                          DropdownMenuItem(child: Text("A"), value: 0),
                          DropdownMenuItem(child: Text("A"), value: 1),
                          DropdownMenuItem(child: Text("A"), value: 2),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          EasyLoading.showInfo("Some Info");
                        },
                        child: Text("EasyLoading"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
