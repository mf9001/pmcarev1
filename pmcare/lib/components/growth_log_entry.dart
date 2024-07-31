import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmcare/model/growth_post.dart';

class GrowthLogEntry extends StatelessWidget {
  List<GrowthPost> GrowthEntry = [];
  String _param_type_ = '';

  GrowthLogEntry(String parameter) {
    this._param_type_ = parameter;
  }

  Future<List<GrowthPost>> getData() async {
    GrowthEntry = [];
    var response = await http
        .get(Uri.http('10.0.2.2:5000', 'growth/get/P555/' + _param_type_));

    var jsonData = jsonDecode(response.body);

    print('jsonData' + jsonData.toString());

    for (var eachPost in jsonData) {
      final post = GrowthPost(
          note: eachPost['note'],
          parameter: eachPost['parameter'],
          amount: eachPost['amount'],
          unit: eachPost['unit'],
          stime: eachPost['stime'],
          docid: eachPost['docid'],
          cwhoprec: eachPost['calc_prec']);
      GrowthEntry.add(post);
    }
    print("LEN" + GrowthEntry.length.toString());
    return GrowthEntry;
    /*
    return Future.delayed(Duration(seconds: 1), () {
      return "I am data";
      // throw Exception("Custom Error");
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data as List<GrowthPost>;
          return ListView.builder(
              itemCount: GrowthEntry.length, //FeedingEntry.length,
              itemBuilder: (BuildContext context, int index) {
                GrowthPost post = data.elementAt(index);
                return GrowthEntryListView(
                    startDate: post.stime,
                    note: post.note,
                    amount: post.amount,
                    unit: post.unit,
                    parameter: post.parameter,
                    docid: post.docid,
                    cwhoprec: post.cwhoprec);
                //return FeedingEntryListView(text: "HI");
              });
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}

class GrowthEntryListView extends StatelessWidget {
  GrowthEntryListView({
    required this.startDate,
    required this.note,
    required this.parameter,
    required this.amount,
    required this.unit,
    required this.docid,
    required this.cwhoprec,
  });

  final String startDate;
  final String note;
  final String parameter;
  final String amount;
  final String unit;
  final String docid;
  final String cwhoprec;

  bool redraw = false;

  Widget show_bside() {
    if (parameter == "Weight") {
      return Icon(
        Icons.scale_rounded,
        size: 20,
        color: const Color.fromARGB(255, 87, 176, 182),
      );
    }
    if (parameter == "Height") {
      return Icon(
        Icons.straighten,
        size: 20,
        color: const Color.fromARGB(255, 87, 176, 182),
      );
    }
    if (parameter == "Head Circumference") {
      return Icon(
        Icons.face,
        size: 20,
        color: const Color.fromARGB(255, 87, 176, 182),
      );
    }
    return Icon(Icons.rotate_left);
  }

  void _delete_record(BuildContext context) {
    print("Doc to Delete" + docid);
    _showAlertDialog(context);
  }

  Future<String> _delete_growth_record_() async {
    var response =
        await http.get(Uri.http('10.0.2.2:5000', 'growth/delete/' + docid));

    //var jsonData = jsonDecode(response.body);
    return response.body;
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Record'),
          content: Text('Do you realy want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _delete_growth_record_();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            startDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Note : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(note),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$amount $unit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Text("$cwhoprec %",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      _delete_record(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.delete_forever)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
