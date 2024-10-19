import 'package:chatapp/models/chatmessage.dart';
import 'package:chatapp/viewmodels/chatviewmodle.dart';
import 'package:chatapp/views/chatscreen.dart';
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

  Widget createChatScreen() {
    return ChangeNotifierProvider<ChatViewModel>.value(
      value: mockChatViewModel,
      child: MaterialApp(
        home: ChatScreen(),
      ),
    );
  }

  group('ChatScreen', () {
    testWidgets('initial state shows empty message list', (WidgetTester tester) async {
      // Arrange: Set up mock view model to return no messages
      when(mockChatViewModel.messages).thenReturn([]);

      // Act: Build the widget
      await tester.pumpWidget(createChatScreen());

      // Assert: Check that the message list is empty
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('No messages'), findsOneWidget);
    });

    testWidgets('sending a message updates the message list', (WidgetTester tester) async {
      // Arrange: Set up the mock to return one message
      final message = ChatMessage(
        id: '1',
        sender: 'Alice',
        receiver: 'Bob',
        message: 'Hello!',
        timestamp: DateTime.now(),
      );
      when(mockChatViewModel.messages).thenReturn([message]);

      // Act: Build the widget
      await tester.pumpWidget(createChatScreen());

      // Assert: Verify the message is displayed
      expect(find.text('Hello!'), findsOneWidget);
    });

    testWidgets('shows loading state while fetching messages', (WidgetTester tester) async {
      // Arrange: Set the loading state to true
      when(mockChatViewModel.isLoading).thenReturn(true);

      // Act: Build the widget
      await tester.pumpWidget(createChatScreen());

      // Assert: Verify that a loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}