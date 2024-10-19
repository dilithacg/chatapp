import 'package:chatapp/models/chatmessage.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ChatMessage Model Tests', () {
    final chatMessage = ChatMessage(
      id: '123',
      sender: 'Alice',
      receiver: 'Bob',
      message: 'Hello Bob!',
      timestamp: DateTime.parse('2024-10-18T12:34:56.789Z'),
    );

    test('ChatMessage toJson serialization', () {
      final json = chatMessage.toJson();
      expect(json['id'], '123');
      expect(json['sender'], 'Alice');
      expect(json['receiver'], 'Bob');
      expect(json['message'], 'Hello Bob!');
      expect(json['timestamp'], '2024-10-18T12:34:56.789Z');
    });

    test('ChatMessage fromJson deserialization', () {
      final json = {
        'id': '123',
        'sender': 'Alice',
        'receiver': 'Bob',
        'message': 'Hello Bob!',
        'timestamp': '2024-10-18T12:34:56.789Z',
      };
      final newMessage = ChatMessage.fromJson(json);
      expect(newMessage.id, '123');
      expect(newMessage.sender, 'Alice');
      expect(newMessage.receiver, 'Bob');
      expect(newMessage.message, 'Hello Bob!');
      expect(newMessage.timestamp, DateTime.parse('2024-10-18T12:34:56.789Z'));
    });
  });
}