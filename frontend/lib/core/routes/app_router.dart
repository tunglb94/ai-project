// clone/frontend/lib/core/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_ai_app/presentation/screens/chat/chat_screen.dart';
import 'package:doctor_ai_app/presentation/screens/home/home_screen.dart';
import 'package:doctor_ai_app/presentation/screens/prescription/prescription_screen.dart';
import 'package:doctor_ai_app/presentation/screens/symptom_analyzer/symptom_analyzer_screen.dart';
import 'package:doctor_ai_app/presentation/screens/lab_result/lab_result_screen.dart';

// TRẢ LẠI ĐÚNG CẤU TRÚC GỐC CỦA BẠN
class AppRouter {
  static const String homeRoute = '/';
  static const String chatRoute = '/chat';
  static const String symptomRoute = '/symptom';
  static const String prescriptionRoute = '/prescription';
  static const String labResultRoute = '/lab_result';

  // SỬA LẠI: router là một biến final, không phải static final
  // để tương thích với cách gọi appRouter.router trong main.dart
  final GoRouter router = GoRouter(
    initialLocation: homeRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: chatRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatScreen();
        },
      ),
      GoRoute(
        path: prescriptionRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const PrescriptionScreen();
        },
      ),
      // Bổ sung các route còn thiếu
      GoRoute(
        path: symptomRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const SymptomAnalyzerScreen();
        },
      ),
      GoRoute(
        path: labResultRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LabResultScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lỗi'),
        ),
        body: Center(
          child: Text('Không tìm thấy trang: ${state.error}'),
        ),
      );
    },
  );
}