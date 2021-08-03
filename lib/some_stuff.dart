import 'package:app_popup_menu/app_popup_menu.dart';
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
                      Popover(
                        child: Text("Popover"),
                        popoverBuilder: (ctx) => Column(
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              color: Colors.red,
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      AppPopupMenu(
                        initialValue: 2,
                        child: Text("Dropdown"),
                        menuItems: [
                          PopupMenuItem(
                            child: Text("A"),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text("A"),
                            value: 2,
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                      ),
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
                      ),
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
