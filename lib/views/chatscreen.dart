import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_screen.dart';
import '../viewmodels/chatviewmodle.dart';
import 'messageinput.dart';
import 'messagelist.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          backgroundColor: Colors.indigo,
          actions: [IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AuthScreen()),
            );
          }, icon: Icon(Icons.exit_to_app,
          color: Colors.white,)),],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(child: MessageList()),
              MessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
