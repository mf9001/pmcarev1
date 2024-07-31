import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pmcare/model/feeding_post.dart';
import 'package:http/http.dart' as http;

class FeedingLogEntry extends StatelessWidget {
  List<FeedingPost> FeedingEntry = [];
  Future<List<FeedingPost>> getData() async {
    FeedingEntry = [];
    var response =
        await http.get(Uri.http('10.0.2.2:5000', 'feeding/get/P555'));

    var jsonData = jsonDecode(response.body);

    print('jsonData' + jsonData.toString());

    for (var eachPost in jsonData) {
      final post = FeedingPost(
          detils: eachPost['detils'],
          bside: eachPost['bside'],
          duration: eachPost['duration'],
          feedtype: eachPost['feedtype'],
          amount: eachPost['amount'],
          unit: eachPost['unit'],
          stime: eachPost['stime']);
      FeedingEntry.add(post);
    }
    print("LEN" + FeedingEntry.length.toString());
    return FeedingEntry;
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
          final data = snapshot.data as List<FeedingPost>;
          return ListView.builder(
              itemCount: FeedingEntry.length, //FeedingEntry.length,
              itemBuilder: (BuildContext context, int index) {
                FeedingPost post = data.elementAt(index);
                return FeedingEntryListView(
                  startDate: post.stime,
                  duration: post.duration,
                  detils: post.detils,
                  bside: post.bside,
                  amount: post.amount,
                  unit: post.unit,
                  feedtype: post.feedtype,
                );
                //return FeedingEntryListView(text: "HI");
              });
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}

class FeedingEntryListView extends StatelessWidget {
  FeedingEntryListView({
    required this.startDate,
    required this.duration,
    required this.detils,
    required this.feedtype,
    this.bside = "",
    this.amount = "",
    this.unit = "",
  });
  final String startDate;
  final String duration;
  final String detils;
  final String feedtype;
  final String bside;
  final String amount;
  final String unit;

  Widget show_bside() {
    if (this.feedtype == "Breastfeeding") {
      return Image.asset("assets/icon_breastfeed.png", width: 30);
    }
    if (this.feedtype == "Bottle Feeding (Formula)") {
      return Image.asset("assets/icon_milkposwer.png", width: 30);
    }
    if (this.feedtype == "Bottle Feeding (Pumped Milk)") {
      return Image.asset("assets/icon_babybottle.png", width: 30);
    }
    return Icon(Icons.rotate_left);
  }

  Widget show_amount() {
    if (this.amount == "0") {
      return Text(bside.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold));
    } else {
      return Text(' $amount $unit',
          style: TextStyle(fontWeight: FontWeight.bold));
    }
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
                          /*Text(
                            'Start Date : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),*/
                          Text(
                            startDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            duration + " mins | ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          show_amount()
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Details : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(detils),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [show_bside()],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.edit_note_rounded)],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.delete_forever)],
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
