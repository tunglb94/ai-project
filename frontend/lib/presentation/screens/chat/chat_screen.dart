// lib/presentation/screens/chat/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart';
import 'package:doctor_ai_app/domain/entities/chat_message_entity.dart'; // Đảm bảo import MessageSender
import 'package:doctor_ai_app/core/theme/app_theme.dart';
import '../../bloc/chat/chat_bloc.dart';
import '../../bloc/chat/chat_event.dart';
import '../../bloc/chat/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // --- Logic quản lý quảng cáo ---
  BannerAd? _topBannerAd;
  BannerAd? _bottomBannerAd;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const InitializeChat());
    _loadTopBannerAd();
    _loadBottomBannerAd();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _topBannerAd?.dispose();
    _bottomBannerAd?.dispose();
    super.dispose();
  }

  void _loadTopBannerAd() {
    _topBannerAd = BannerAd(
      adUnitId: AdHelper.topBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _topBannerAd = ad as BannerAd),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  void _loadBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bottomBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _bottomBannerAd = ad as BannerAd),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }
  // --- Kết thúc logic quảng cáo ---

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(_messageController.text));
      _messageController.clear();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trợ lý AI'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Banner trên
            if (_topBannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _topBannerAd!.size.width.toDouble(),
                height: _topBannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _topBannerAd!),
              ),
            // Nội dung gốc với giao diện bong bóng chat đẹp
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: BlocConsumer<ChatBloc, ChatState>(
                      listener: (context, state) {
                        if (state is ChatSuccess) {
                          _scrollToBottom();
                        }
                      },
                      builder: (context, state) {
                        if (state is ChatInitial || (state is ChatLoading && state.messages.isEmpty)) {
                            return const _WelcomeMessage();
                        }
                        
                        if (state is ChatSuccess || (state is ChatLoading && state.messages.isNotEmpty)) {
                          final messages = state.messages;
                          final isLoading = state is ChatLoading;

                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            itemCount: messages.length + (isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (isLoading && index == messages.length) {
                                return const _TypingIndicator();
                              }
                              final message = messages[index];
                              // SỬA LỖI TẠI ĐÂY: SO SÁNH VỚI ENUM CHỨ KHÔNG PHẢI CHUỖI
                              return _ChatMessageBubble(
                                text: message.content, 
                                isUserMessage: message.sender == MessageSender.user // ĐÃ SỬA
                              );
                            },
                          );
                        }
                        
                        if (state is ChatFailure) {
                          return Center(child: Text('Đã có lỗi xảy ra: ${state.error}'));
                        }

                        return const _WelcomeMessage();
                      },
                    ),
                  ),
                  _MessageInputField(
                    controller: _messageController,
                    onSend: _sendMessage,
                  ),
                ],
              ),
            ),
             // Banner dưới
            if (_bottomBannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _bottomBannerAd!.size.width.toDouble(),
                height: _bottomBannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bottomBannerAd!),
              ),
          ],
        ),
      ),
    );
  }
}

// === CÁC WIDGET GIAO DIỆN ĐẸP MẮT ĐƯỢC KHÔI PHỤC ===

class _ChatMessageBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const _ChatMessageBubble({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Quyết định màu nền và màu chữ dựa trên người gửi
    // Nếu là tin nhắn người dùng: nền màu surface (trắng/xám nhạt), chữ màu onSurface (đen/xám đậm)
    // Nếu là tin nhắn AI: nền màu primary (xanh của app), chữ màu trắng
    final Color bubbleColor = isUserMessage
        ? theme.colorScheme.surface // Tin nhắn người dùng: nền trắng/xám nhạt
        : theme.colorScheme.primary; // Tin nhắn AI: nền xanh chính của app

    final Color textColor = isUserMessage
        ? theme.colorScheme.onSurface // Tin nhắn người dùng: chữ đen/xám đậm
        : Colors.white; // Tin nhắn AI: chữ trắng

    // Xác định căn chỉnh tin nhắn: người dùng bên phải, AI bên trái
    final MainAxisAlignment alignment = isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: alignment, // Căn chỉnh toàn bộ hàng bong bóng
        crossAxisAlignment: CrossAxisAlignment.end, // Căn chỉnh các phần tử theo chiều dọc

        children: [
          // Icon của AI chỉ hiển thị khi KHÔNG phải tin nhắn người dùng (tức là tin nhắn AI)
          // và được đặt ở ĐẦU Row khi căn chỉnh bên trái
          if (!isUserMessage) // Nếu là tin nhắn AI
            const CircleAvatar(
              backgroundColor: AppTheme.primaryColor, // Màu nền của icon AI
              // Để sử dụng icon con gấu từ assets:
              // child: Image.asset('assets/images/bear_icon.png', width: 20, height: 20),
              // Đảm bảo bạn đã thêm 'assets/images/' vào pubspec.yaml và có file bear_icon.png
              child: Icon(Icons.support_agent, color: Colors.white, size: 20), // Icon mặc định nếu chưa có asset
            ),
          
          // Khoảng cách giữa icon và bong bóng chat cho AI
          if (!isUserMessage)
            const SizedBox(width: 8),

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: bubbleColor, // Sử dụng màu nền đã quyết định
                borderRadius: BorderRadius.only(
                  // Bo góc trên luôn tròn
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  // Bo góc dưới trái: tròn nếu là tin nhắn người dùng (vì nó nằm cuối), không tròn nếu là AI (tạo "đuôi" bên trái)
                  bottomLeft: isUserMessage ? const Radius.circular(20) : Radius.zero, 
                  // Bo góc dưới phải: không tròn nếu là tin nhắn người dùng (tạo "đuôi" bên phải), tròn nếu là AI (vì nó nằm cuối)
                  bottomRight: isUserMessage ? Radius.zero : const Radius.circular(20), 
                ),
              ),
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor, // Sử dụng màu chữ đã quyết định
                ),
              ),
            ),
          ),
          
          // Khoảng cách và icon người dùng (nếu có)
          // Đặt khoảng cách và icon người dùng SAU bong bóng chat để nó hiển thị bên phải
          if (isUserMessage) // Nếu là tin nhắn người dùng
            const SizedBox(width: 8), 
          // Icon người dùng (TÙY CHỌN):
          // Nếu bạn muốn có icon cho người dùng, bạn có thể thêm một CircleAvatar khác ở đây.
          // Ví dụ:
          // if (isUserMessage)
          //   const CircleAvatar(
          //     backgroundColor: Colors.blueGrey, // Ví dụ màu nền icon người dùng
          //     child: Icon(Icons.person, color: Colors.white, size: 20),
          //   ),
        ],
      ),
    );
  }
}

class _MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInputField({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                decoration: const InputDecoration(
                  hintText: 'Nhập tin nhắn của bạn...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.all(12),
              ),
              icon: const Icon(Icons.send_rounded, color: Colors.white),
              onPressed: onSend,
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.health_and_safety_outlined,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Bắt đầu cuộc trò chuyện',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy hỏi tôi bất cứ điều gì liên quan đến sức khỏe.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return _ChatMessageBubble(
      text: '...',
      isUserMessage: false,
    );
  }
}