import 'package:flutter/material.dart';
import '../models/chat_item_model.dart';

class ChatItem extends StatelessWidget {
  final ChatItemModel chat;

  ChatItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(chat.imageAsset),
      ),
      title: Text(chat.name),
      subtitle: Text(chat.message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Ensure the Column takes minimum space
        children: [
          Text(
            chat.time,
            style: TextStyle(
              color: Color.fromARGB(255, 129, 128, 128),
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4), // Add some space between the time and the icon
          Icon(
            Icons.circle,
            color: Color.fromARGB(255, 28, 136, 31),
            size: 12,
          ), // Notification indicator
        ],
      ),
    );
  }
}
