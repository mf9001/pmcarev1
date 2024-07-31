import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
        text: "When did you start giving her formula?",
        isSentByMe: false,
        time: "12:00 AM"),
    Message(text: "3 or 4 times", isSentByMe: true, time: "11.31 AM"),
    Message(
        text: "How many times did she throw up today?",
        isSentByMe: false,
        time: "11.31 AM"),
    Message(
        text: "My baby throwing up milk after formula feeds",
        isSentByMe: true,
        time: "11.30 AM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 141, 216, 228),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 216, 228),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('lib/assets/midwife.jpg'),
            ),
            SizedBox(width: 15),
            Text(
              "Midwife Anne",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messages[index];
                    return ChatBubble(
                      message: message,
                    );
                  },
                ),
              ),
            ),
            Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Color.fromARGB(255, 108, 215, 230)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 222, 222),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: const Color.fromARGB(255, 224, 222, 222)),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {
                // Handle attach file button press
              },
            ),
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: "Type your message...",
                ),
                onSubmitted: (text) {
                  // Handle text submission
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                // Handle mic button press
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Handle send button press
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
