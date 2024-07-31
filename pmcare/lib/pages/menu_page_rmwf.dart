import 'package:flutter/material.dart';
import '/pages/schlist_page.dart';

//---------------------------------------------Role = mwf

class MwfMenuPage extends StatelessWidget {
  const MwfMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PM Care Menu',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'PM Care Menu',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 211, 108, 60),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 239, 242, 243),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SchListpage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 211, 108, 60),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Center(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month,
                            size: 50, color: Colors.black87),
                        Text(
                          'Schedule',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
