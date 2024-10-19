import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../viewmodels/chatviewmodle.dart';
import 'ChatMessageWidget.dart';


class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);


    if (chatViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: chatViewModel.messages.length,
      itemBuilder: (context, index) {
        final message = chatViewModel.messages[index];
        final isMe = message.sender == 'User'; // Check if the message is from the current user
        final isFirstInSequence = index == 0 || message.sender != chatViewModel.messages[index - 1].sender;

        return ChatMessageWidget(
          message: message.message,
          username: message.sender,
          userImage: null,
          isMe: isMe,
          isFirstInSequence: isFirstInSequence,
        );
      },
    );
  }
}
