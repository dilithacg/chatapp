import 'package:hive/hive.dart';

part 'chatmessage.g.dart';

@HiveType(typeId: 0)
class ChatMessage {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String sender;

  @HiveField(2)
  final String receiver;

  @HiveField(3)
  final String message;

  @HiveField(4)
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'],
    sender: json['sender'],
    receiver: json['receiver'],
    message: json['message'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sender': sender,
    'receiver': receiver,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}
