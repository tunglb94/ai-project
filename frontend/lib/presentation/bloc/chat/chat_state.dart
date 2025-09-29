import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat_message_entity.dart';

abstract class ChatState extends Equatable {
  final List<ChatMessage> messages;
  const ChatState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  final List<ChatMessage>? previousMessages;
  ChatLoading({this.previousMessages}) : super(messages: previousMessages ?? []);

  @override
  List<Object> get props => [identityHashCode(this), previousMessages ?? []];
}

class ChatSuccess extends ChatState {
  const ChatSuccess({required List<ChatMessage> messages}) : super(messages: messages);

  @override
  List<Object> get props => [messages];
}

class ChatFailure extends ChatState {
  final String error;
  final List<ChatMessage> messages;

  const ChatFailure(this.error, {this.messages = const []}) : super(messages: messages);

  @override
  List<Object> get props => [error, messages];
}