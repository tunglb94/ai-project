import 'package:equatable/equatable.dart';

class ChatResponseModel extends Equatable {
  final String answer;

  const ChatResponseModel({required this.answer});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
    };
  }

  @override
  List<Object?> get props => [answer];
}