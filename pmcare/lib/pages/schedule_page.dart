import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmcare/pages/visitsentry_page.dart';
import '/pages/schlist_page.dart';
import '/model/confirmed_app_post.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _ShedulepageState();
}

class _ShedulepageState extends State<SchedulePage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ConfirmedAppInfo(),
    SchListpage(),
    Text("History"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 222, 222),
        appBar: AppBar(
          title: const Text(
            'Visits Info',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 167, 233, 226),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Upcoming Visit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp),
              label: 'New Visit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'History',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ConfirmedAppInfo extends StatelessWidget {
  List<ConfirmedAppPost> ConfirmedAppEntry = [];

  Future<List<ConfirmedAppPost>> getData() async {
    ConfirmedAppEntry = [];
    var response =
        await http.get(Uri.http('10.0.2.2:5000', 'schedule/cofirmedapp/P555'));

    var jsonData = jsonDecode(response.body);

    print('jsonData' + jsonData.toString());

    var eachPost = jsonData;

    final post = ConfirmedAppPost(
        slotid: eachPost['slotid'],
        status: eachPost['status'],
        day: eachPost['day'],
        uniqid: eachPost['uniqid'],
        email: eachPost['email'],
        phone: eachPost['phone'],
        role: eachPost['role'],
        mwfid: eachPost['mwfid'],
        name: eachPost['name']);
    ConfirmedAppEntry.add(post);

    print("LEN" + ConfirmedAppEntry.length.toString());
    return ConfirmedAppEntry;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data as List<ConfirmedAppPost>;
          return ListView.builder(
              itemCount: ConfirmedAppEntry.length, //FeedingEntry.length,
              itemBuilder: (BuildContext context, int index) {
                ConfirmedAppPost post = data.elementAt(index);
                return ConfirmedAppListView(
                  day: post.day,
                  name: post.name,
                  phone: post.phone,
                  slotid: post.slotid,
                  email: post.email,
                );
                //return FeedingEntryListView(text: "HI");
              });
        } else {
          return Text("Loading...");
        }
      },
    );
    //return ConfirmedAppListView(day: "his", name: "Max Fer");
  }
}

class ConfirmedAppListView extends StatelessWidget {
  ConfirmedAppListView(
      {required this.day,
      required this.name,
      required this.phone,
      required this.slotid,
      required this.email}
      /*{required this.mwfid,
      required this.slotid,
      required this.status,
      required this.day,
      required this.uniqid,
      required this.email,
      required this.role,
      required this.phone,
      required this.name}*/
      );
  final String day;
  final String name;
  final String phone;
  final String slotid;
  final String email;
  /*final String slotid;
  final String mwfid;
  final String status;
  final String day;
  final String uniqid;
  final String email;
  final String role;
  final String phone;
  final String name;*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text("Confirmed Visit",
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/icon_nurse.png",
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(day,
                  style:
                      TextStyle(fontSize: 33.0, fontWeight: FontWeight.bold)),
              Text(slotid,
                  style:
                      TextStyle(fontSize: 29.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text(name,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(phone,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(email,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Cancel the Visit")),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
