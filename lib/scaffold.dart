import 'package:flutter/material.dart';

class SimpleScaffold extends StatelessWidget {
  final String? title;
  final bool? hasBack;
  final Widget? body;

  SimpleScaffold({
    Key? key,
    this.title,
    this.hasBack = true,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text(
          title ?? "Title",
          style: TextStyle(
            color: Color(0xFF181818),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF181818),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: body,
    );
  }
}
