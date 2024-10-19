import 'package:chatapp/models/chatmessage.dart';
import 'package:chatapp/viewmodels/chatviewmodle.dart';
import 'package:chatapp/views/messagelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';


class MockChatViewModel extends Mock implements ChatViewModel {}

void main() {
  late MockChatViewModel mockChatViewModel;

  setUp(() {
    mockChatViewModel = MockChatViewModel();
  });

  Widget createMessageList() {
    return ChangeNotifierProvider<ChatViewModel>.value(
      value: mockChatViewModel,
      child: MaterialApp(
        home: Scaffold(
          body: MessageList(),
        ),
      ),
    );
  }

  group('MessageList', () {
    testWidgets('shows loading indicator when loading', (WidgetTester tester) async {
      // Arrange: Set the loading state to true
      when(mockChatViewModel.isLoading).thenReturn(true);

      // Act: Build the widget
      await tester.pumpWidget(createMessageList());

      // Assert: Verify that the loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays messages when available', (WidgetTester tester) async {
      // Arrange: Set up mock messages
      final messages = [
        ChatMessage(
          id: '1',
          sender: 'Alice',
          receiver: 'Bob',
          message: 'Hello!',
          timestamp: DateTime.now(),
        ),
        ChatMessage(
          id: '2',
          sender: 'Bob',
          receiver: 'Alice',
          message: 'Hi there!',
          timestamp: DateTime.now(),
        ),
      ];
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.messages).thenReturn(messages);

      // Act: Build the widget
      await tester.pumpWidget(createMessageList());

      // Assert: Verify that the messages are displayed
      expect(find.text('Hello!'), findsOneWidget);
      expect(find.text('Hi there!'), findsOneWidget);
    });

    testWidgets('displays empty state when no messages', (WidgetTester tester) async {
      // Arrange: Set up mock messages
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.messages).thenReturn([]);

      // Act: Build the widget
      await tester.pumpWidget(createMessageList());

      // Assert: Verify that the empty state message is displayed
      expect(find.text('No messages'), findsOneWidget);
    });
  });
}