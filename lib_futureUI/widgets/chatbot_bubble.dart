import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool showAndroidIcon;

  ChatBubble({required this.message, this.showAndroidIcon = false});

  @override
  Widget build(BuildContext context) {
    final bg = message.isSentByMe
        ? Color.fromARGB(255, 224, 222, 222)
        : Color.fromARGB(255, 164, 220, 228);
    final align =
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = message.isSentByMe
        ? BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisAlignment: message.isSentByMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (showAndroidIcon)
              Icon(Icons.android,
                  color: Color.fromARGB(255, 19, 210, 240), size: 24),
            if (showAndroidIcon) SizedBox(width: 5),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: radius,
              ),
              child: Column(
                crossAxisAlignment: align,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.time,
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.done_all, size: 15, color: Colors.black54),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
