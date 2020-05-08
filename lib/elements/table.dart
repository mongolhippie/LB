import 'package:flutter/material.dart';

class GetTable extends StatefulWidget {
  int indexCol;
  bool as;

  final void Function(int, bool) callback;
  final List<String> columns;
  final List<DataRow> rows;

  GetTable(this.as, this.indexCol, this.callback, this.columns, this.rows);

  @override
  _GetTableState createState() => _GetTableState();
}

class _GetTableState extends State<GetTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 30,
      horizontalMargin: 0,
      sortColumnIndex: widget.indexCol,
      sortAscending: widget.as,
      columns: createColumns(),
      rows: widget.rows,
    );
  }

  List<DataColumn> createColumns() {
    var list = List<DataColumn>();
    for (var i = 0; i < widget.columns.length; i++) {
      list.add(DataColumn(
        numeric: true,
        label: Text(
          widget.columns[i],
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        onSort: (index, bool) {
          widget.callback(index, bool);
        },
      ));
    }
    return list;
  }
}
