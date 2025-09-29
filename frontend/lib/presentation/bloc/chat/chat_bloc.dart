import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../domain/repositories/ai_repository.dart';
import '../../../domain/entities/chat_message_entity.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AiRepository aiRepository;

  ChatBloc({required this.aiRepository}) : super(const ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<SendVoiceMessage>(_onSendVoiceMessage);
    on<InitializeChat>(_onInitializeChat);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final currentMessages = List<ChatMessage>.from(state.messages);
    currentMessages.add(ChatMessage(
      content: event.message,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    ));
    emit(ChatLoading(previousMessages: currentMessages));

    try {
      final aiResponse = await aiRepository.getChatResponse(event.message);
      currentMessages.add(ChatMessage(
        content: aiResponse.answer,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ));
      emit(ChatSuccess(messages: currentMessages));
    } catch (e) {
      currentMessages.add(ChatMessage(
        content: 'Lỗi: ${e.toString()}',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ));
      emit(ChatFailure('Failed to get chat response', messages: currentMessages));
    }
  }

  Future<void> _onSendVoiceMessage(SendVoiceMessage event, Emitter<ChatState> emit) async {
    final currentMessages = List<ChatMessage>.from(state.messages);
    currentMessages.add(ChatMessage(
      content: "Bạn: (Tin nhắn giọng nói)",
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    ));
    emit(ChatLoading(previousMessages: currentMessages));

    try {
      final audioBase64 = base64Encode(event.audioContent);
      final response = await aiRepository.sendVoiceChat(
        audioBase64: audioBase64,
        audioFormat: event.audioFormat,
        sampleRateHertz: event.sampleRateHertz,
        languageCode: event.languageCode,
      );

      final aiTextResponse = response['text_response'] as String;
      final aiAudioResponseBase64 = response['audio_response'] as String;

      currentMessages.removeLast();
      currentMessages.add(ChatMessage(
        content: aiTextResponse,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
        audioResponseBase64: aiAudioResponseBase64,
      ));
      emit(ChatSuccess(messages: currentMessages));
    } catch (e) {
      currentMessages.add(ChatMessage(
        content: 'Lỗi xử lý giọng nói: ${e.toString()}',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ));
      emit(ChatFailure('Failed to process voice message', messages: currentMessages));
    }
  }

  Future<void> _onInitializeChat(InitializeChat event, Emitter<ChatState> emit) async {
    if (state.messages.isEmpty) {
      final initialMessage = ChatMessage(
        content: "Chào bạn! Tôi là Doctor AI, trợ lý y tế AI. Tôi không phải là bác sĩ và thông tin tôi cung cấp chỉ mang tính chất tham khảo, không thay thế cho lời khuyên của bác sĩ chuyên khoa.\n\nHãy cho tôi biết nếu bạn có bất kỳ câu hỏi nào về sức khỏe hoặc cần thông tin y tế. Tôi sẽ cố gắng hết sức để giúp bạn.",
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );
      emit(ChatSuccess(messages: [initialMessage]));
    }
  }
}