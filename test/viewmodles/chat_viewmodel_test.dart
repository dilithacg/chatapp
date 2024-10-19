import 'package:chatapp/utils/locator.dart';
import 'package:chatapp/viewmodels/chatviewmodle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../lib/models/chatmessage.dart';
import '../../lib/services/mock_api_service.dart';
import '../../lib/services/apiservice.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ChatMessageAdapter());
    await Hive.openBox<ChatMessage>('messages');
  });

  tearDown(() async {
    await Hive.box<ChatMessage>('messages').clear();
    await Hive.deleteFromDisk();
  });

  group('ChatViewModel', () {
    late ChatViewModel chatViewModel;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      // Register the mock service with the locator
      locator.registerSingleton<ApiService>(mockApiService);
      chatViewModel = ChatViewModel();
    });

    tearDown(() {
      locator.reset();
    });

    test('fetchMessages - success', () async {
      // Arrange
      final messages = [
        ChatMessage(id: '1', sender: 'User1', receiver: 'User2', message: 'Hello!', timestamp: DateTime.now()),
      ];

      when(mockApiService.fetchMessages()).thenAnswer((_) async => messages);

      // Act
      await chatViewModel.fetchMessages();

      // Assert
      expect(chatViewModel.messages.length, 1);
      expect(chatViewModel.messages.first.message, 'Hello!');
    });

    test('fetchMessages - failure', () async {
      // Arrange
      when(mockApiService.fetchMessages()).thenThrow(Exception('Failed to fetch'));

      // Act
      await chatViewModel.fetchMessages();

      // Assert
      expect(chatViewModel.messages.length, 0);
    });

    test('sendMessage - success', () async {
      // Arrange
      final message = ChatMessage(id: '1', sender: 'User1', receiver: 'User2', message: 'Hello!', timestamp: DateTime.now());

      when(mockApiService.sendMessage(message)).thenAnswer((_) async => null);

      // Act
      await chatViewModel.sendMessage(message);

      // Assert
      expect(chatViewModel.messages.length, 1);
      expect(chatViewModel.messages.first.message, 'Hello!');
    });

    test('sendMessage - failure', () async {
      // Arrange
      final message = ChatMessage(id: '1', sender: 'User1', receiver: 'User2', message: 'Hello!', timestamp: DateTime.now());

      when(mockApiService.sendMessage(message)).thenThrow(Exception('Failed to send'));

      // Act
      await chatViewModel.sendMessage(message);

      // Assert
      expect(chatViewModel.messages.length, 1);
    });
  });
}
