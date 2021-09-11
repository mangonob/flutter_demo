import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class TableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Text("Name"),
              Text("Age"),
              Text("Phone Number"),
            ],
          ),
          TableRow(
            children: [
              Text("Tom"),
              Text("18"),
              Text("181-3333-4444"),
            ],
          ),
          TableRow(
            children: [
              Text("Jerry"),
              Text("24"),
              Text("300-4223"),
            ],
          ),
          TableRow(
            children: [
              Text("Harry"),
              Text("30"),
              Text("186-3333-2222"),
            ],
          ),
        ],
      ),
    );
  }
}
