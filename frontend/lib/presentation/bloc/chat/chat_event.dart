import 'package:equatable/equatable.dart';
import 'dart:typed_data';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class SendVoiceMessage extends ChatEvent {
  final Uint8List audioContent;
  final String audioFormat;
  final int sampleRateHertz;
  final String languageCode;

  const SendVoiceMessage({
    required this.audioContent,
    required this.audioFormat,
    required this.sampleRateHertz,
    required this.languageCode,
  });

  @override
  List<Object> get props => [audioContent, audioFormat, sampleRateHertz, languageCode];
}

class InitializeChat extends ChatEvent {
  const InitializeChat();

  @override
  List<Object> get props => [];
}