import 'package:chatapp/views/ChatMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ChatMessageWidget Tests', () {
    testWidgets('renders message correctly', (WidgetTester tester) async {
      const message = 'Hello, how are you?';
      const username = 'User1';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatMessageWidget(
              message: message,
              username: username,
              isMe: true,
              isFirstInSequence: true,
            ),
          ),
        ),
      );

      // Check if the message is displayed
      expect(find.text(message), findsOneWidget);
      // Check if the username is displayed
      expect(find.text(username), findsOneWidget);
    });

    testWidgets('displays user image when provided', (WidgetTester tester) async {
      const message = 'Hello, how are you?';
      const userImageUrl = 'https://example.com/image.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatMessageWidget(
              message: message,
              userImage: userImageUrl,
              isMe: false,
              isFirstInSequence: true,
            ),
          ),
        ),
      );


      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byWidgetPredicate((Widget widget) {
        return widget is CircleAvatar && widget.backgroundImage is NetworkImage && (widget.backgroundImage as NetworkImage).url == userImageUrl;
      }), findsOneWidget);
    });

    testWidgets('applies correct styles for messages sent by the user', (WidgetTester tester) async {
      const message = 'Hello!';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatMessageWidget(
              message: message,
              isMe: true,
              isFirstInSequence: true,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.grey[300]);

      final padding = tester.widget<Container>(find.byType(Container).last).padding as EdgeInsets;
      expect(padding.top, 10);
    });

    testWidgets('applies correct styles for messages received from others', (WidgetTester tester) async {
      const message = 'Hi there!';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatMessageWidget(
              message: message,
              isMe: false,
              isFirstInSequence: true,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.green[600]);

      final padding = tester.widget<Container>(find.byType(Container).last).padding as EdgeInsets;
      expect(padding.top, 10);
    });
  });
}