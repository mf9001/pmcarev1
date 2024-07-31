import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '/pages/feedingEntry_page.dart';
import 'package:http/http.dart' as http;
import '/model/feeding_post.dart';
import '/components/feeding_log_entry.dart';

class FeedingPage extends StatefulWidget {
  const FeedingPage({super.key});

  @override
  State<FeedingPage> createState() => _FeedingpageState();
}

class _FeedingpageState extends State<FeedingPage> {
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
    FeedingLogEntry(),
    FeedingEntryForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 242, 241),
        appBar: AppBar(
          title: const Text(
            'Feeding Log',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 167, 233, 226),
          centerTitle: true,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp),
              label: 'New Entry',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
