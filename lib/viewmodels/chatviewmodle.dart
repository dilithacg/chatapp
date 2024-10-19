import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/chatmessage.dart';
import '../services/apiservice.dart';
import '../utils/locator.dart';

class ChatViewModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>(); // Dependency Injection via locator
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  // Fetch messages from the API
  Future<void> fetchMessages() async {
    _isLoading = true;
    notifyListeners();

    try {
      _messages = await _apiService.fetchMessages();
    } catch (e) {
      // Handle error
      print('Error fetching messages: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send a message
  Future<void> sendMessage(ChatMessage message) async {
    try {
      await _apiService.sendMessage(message);
      _messages.add(message);

      // Save the message to Hive for offline access
      final box = Hive.box<ChatMessage>('messages');
      await box.add(message);

      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error sending message: $e');
    }
  }
}
