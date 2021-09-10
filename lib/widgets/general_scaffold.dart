import 'package:flutter/material.dart';

class GeneralScaffold extends StatelessWidget {
  final String? title;
  final Widget body;

  GeneralScaffold({
    Key? key,
    this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
      ),
      body: body,
    );
  }
}
