import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/popover.dart';

class SomeStuff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RotatedBox(
          quarterTurns: 1,
          child: Overlay(
            initialEntries: [
              OverlayEntry(builder: (ctx) {
                return ListView(
                  children: List.generate(100, (index) {
                    return Container(
                      height: 50,
                      child: Align(
                        alignment: [
                          Alignment.centerLeft,
                          Alignment.center,
                          Alignment.centerRight,
                        ][index % 3],
                        child: Popover(
                          popoverBuilder: (ctx, dismiss) => Column(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(0x22),
                                        offset: Offset.zero,
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                      )
                                    ]),
                                width: 100,
                                child: Column(
                                  children: List.generate(
                                    4,
                                    (index) => ListTile(
                                      title: Text(
                                        "Option-$index",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onTap: dismiss,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: Text("Popover"),
                        ),
                      ),
                    );
                  }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
