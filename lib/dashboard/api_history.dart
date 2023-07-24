import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryTable extends StatefulWidget {
  @override
  _HistoryTableState createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  List<Map<String, dynamic>> historyData = [];

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }

  Future<void> getDataFromDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'webservice.db');
    final database = await openDatabase(path, version: 1);
    final result = await database.query('history');

    setState(() {
      historyData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name File')),
        DataColumn(label: Text('Emosi')),
        DataColumn(label: Text('Waktu')),
      ],
      rows: historyData.map((data) {
        return DataRow(
          cells: [
            DataCell(Text(data['name_file'])),
            DataCell(Text(data['emosi'])),
            DataCell(Text(data['waktu'])),
          ],
        );
      }).toList(),
    );
  }
}
