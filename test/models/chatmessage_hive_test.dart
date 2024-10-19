import 'package:chatapp/models/chatmessage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';


class MockHiveBox extends Mock implements Box {}

void main() {
  group('ChatMessage Hive Tests', () {
    late MockHiveBox mockBox;

    setUp(() {
      mockBox = MockHiveBox();
    });

    test('Store and retrieve ChatMessage from Hive box', () async {
      final chatMessage = ChatMessage(
        id: '123',
        sender: 'Alice',
        receiver: 'Bob',
        message: 'Hello Bob!',
        timestamp: DateTime.now(),
      );


      when(mockBox.put('123', chatMessage)).thenAnswer((_) async => Future.value());

      // Call the Hive box put method
      await mockBox.put('123', chatMessage);

      // Simulate retrieval of the same message
      when(mockBox.get('123')).thenReturn(chatMessage);

      final retrievedMessage = mockBox.get('123');

      // Assertions
      expect(retrievedMessage, isA<ChatMessage>());
      expect(retrievedMessage.id, chatMessage.id);
      expect(retrievedMessage.message, chatMessage.message);
    });
  });
}