import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 138, 218, 228),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('lib/assets/midwife.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Midwife',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '08:55',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildActionButton(Icons.mic, Colors.white, Colors.black),
                    _buildActionButton(
                        Icons.videocam_off, Colors.grey, Colors.black),
                    _buildActionButton(Icons.chat, Colors.white, Colors.black),
                    _buildActionButton(
                        Icons.call_end, Colors.red, Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: iconColor,
        iconSize: 30,
        onPressed: () {
          // Handle button action
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Screen UI',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CallScreen(),
    );
  }
}
