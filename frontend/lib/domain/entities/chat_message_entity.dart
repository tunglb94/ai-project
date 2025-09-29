import 'package:equatable/equatable.dart';

enum MessageSender { user, ai }

class ChatMessage extends Equatable {
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final String? audioResponseBase64; // Thêm trường này để lưu audio base64

  const ChatMessage({
    required this.content,
    required this.sender,
    required this.timestamp,
    this.audioResponseBase64, // Cho phép null
  });

  @override
  List<Object?> get props => [content, sender, timestamp, audioResponseBase64];
}