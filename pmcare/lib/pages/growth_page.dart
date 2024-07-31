import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '/pages/feedingEntry_page.dart';
import 'package:http/http.dart' as http;
import '/model/feeding_post.dart';
import 'package:pmcare/components/growth_log_entry.dart';
import 'package:pmcare/pages/visitsentry_page.dart';
import 'package:pmcare/pages/growthentry_page.dart';

class GrowthPage extends StatefulWidget {
  const GrowthPage({super.key});

  @override
  State<GrowthPage> createState() => _FeedingpageState();
}

class _FeedingpageState extends State<GrowthPage> {
  void showFeedingEntryFom() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => FeedingEntryForm());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    GrowthLogEntry("Weight"),
    GrowthLogEntry("Height"),
    GrowthLogEntry("Head Circumference"),
    GrowthEntryForm()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Growth Tracker',
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
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.scale),
              label: 'Wight',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.straighten),
              label: 'Height',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Head',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp),
              label: 'New',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
