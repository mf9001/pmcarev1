import 'package:flutter/material.dart';
import '../models/chat_item_model.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatItemModel> pinnedChats = [];
  List<ChatItemModel> allChats = [];

  @override
  void initState() {
    super.initState();
    fetchChatData();
  }

  Future<void> fetchChatData() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      pinnedChats = [
        ChatItemModel(
          name: "Midwife Anne",
          message: "I will explain when I visit",
          time: "10:27 AM",
          imageAsset: 'lib/assets/midwife.jpg',
        ),
        ChatItemModel(
          name: "Midwife Pamela",
          message: "Hi, good to hear he's better now",
          time: "9:48 AM",
          imageAsset: 'lib/assets/midwife2.jpg',
        ),
      ];

      allChats = [
        ChatItemModel(
          name: "Shanika",
          message: "Thank you. That was helpful",
          time: "11:24 AM",
          imageAsset: 'lib/assets/mother.jpeg',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 108, 215, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 215, 230),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Row(
          children: [
            SizedBox(width: 5),
            Text(
              "Chat Messages",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 73, 211, 230),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Handle new message button press
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'PINNED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  ...pinnedChats.map((chat) => buildChatCard(chat)).toList(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'ALL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  ...allChats.map((chat) => buildChatCard(chat)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChatCard(ChatItemModel chat) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(chat.imageAsset),
        ),
        title: Text(chat.name),
        subtitle: Text(chat.message),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(chat.time, style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(height: 4),
            Icon(Icons.circle,
                color: Color.fromARGB(255, 24, 173, 37),
                size: 12), // Notification indicator
          ],
        ),
      ),
    );
  }
}
