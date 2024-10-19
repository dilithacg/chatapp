import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chatmessage.dart';

import '../viewmodels/chatviewmodle.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = ChatMessage(
        id: DateTime.now().toString(),
        sender: 'User',
        receiver: 'Receiver',
        message: _controller.text,
        timestamp: DateTime.now(),
      );

      Provider.of<ChatViewModel>(context, listen: false).sendMessage(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color:  Colors.indigo,

              ),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
