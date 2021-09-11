import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class DataTableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            color: Colors.white,
            child: DataTable(
              showBottomBorder: false,
              dataRowHeight: 44,
              headingRowHeight: 44,
              dividerThickness: 0,
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
                DataColumn(label: Text("Year")),
              ],
              rows: [
                for (final _ in List.filled(100, 0))
                  DataRow(cells: [
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                    DataCell(Text("SomeData")),
                  ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
