import 'package:beta_projek/dashboard/model.dart';
import 'package:flutter/material.dart';
import 'network.dart';

class HistoryParkir extends StatefulWidget {
  @override
  State<HistoryParkir> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HistoryParkir> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late List<Detek> detek;
  var isLoaded = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    getRecord();
    _scrollController = ScrollController();
  }

  Future<void> getRecord() async {
    detek = await DetekApi().getAllDetek();
    if (detek != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void _scrollLeft() {
    _scrollController!.animateTo(
      _scrollController!.offset - 200,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController!.animateTo(
      _scrollController!.offset + 200,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<List<Detek>>(
        future: DetekApi().getAllDetek(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Detek> detek = snapshot.data ?? [];
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Waktu'),
                      ),
                      DataColumn(
                        label: Text('Emosi'),
                      ),
                      DataColumn(
                        label: Text('Name_File'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      detek.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text(detek[index].Waktu),
                          ),
                          DataCell(
                            Text(detek[index].Emosi),
                          ),
                          DataCell(
                            Text(detek[index].Name_File),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
