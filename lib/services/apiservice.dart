import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/chatmessage.dart';

class ApiService {
  final String apiUrl = 'https://apiurl.com/api/chat';
  final Box<ChatMessage> _messageBox = Hive.box<ChatMessage>('messages');  // Access the Hive box

  // Fetch messages from API or Hive if offline
  Future<List<ChatMessage>> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<ChatMessage> messages = jsonData.map((json) => ChatMessage.fromJson(json)).toList();

        // Save fetched messages to Hive
        for (var message in messages) {
          _messageBox.put(message.id, message);
        }

        return messages;
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      // If API call fails, return locally stored messages from Hive
      return _messageBox.values.toList();
    }
  }

  // Send message to API and save it locally in Hive
  Future<void> sendMessage(ChatMessage message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(message.toJson()),
      );

      if (response.statusCode == 201) {
        // If successful, store the message in Hive
        _messageBox.put(message.id, message);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      // Save message locally in Hive even if the API call fails
      _messageBox.put(message.id, message);
    }
  }
}
