// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ĐÃ XÓA unused_import này
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Thêm import này

import 'core/constants/app_constants.dart';
import 'core/routes/app_router.dart';
import 'core/services/api_service.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/ai_remote_datasource.dart';
import 'data/repositories/ai_repository_impl.dart';
import 'domain/repositories/ai_repository.dart';
import 'presentation/bloc/chat/chat_bloc.dart';
import 'presentation/bloc/lab_result_analyzer/lab_result_analyzer_bloc.dart';
import 'presentation/bloc/symptom_analyzer/symptom_analyzer_bloc.dart';
import 'presentation/bloc/prescription/prescription_bloc.dart';

// Sửa hàm main thành async
void main() async {
  // Thêm 2 dòng này để khởi tạo AdMob
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  // Giữ nguyên phần còn lại của bạn
  final http.Client client = http.Client();
  // const FlutterSecureStorage secureStorage = FlutterSecureStorage(); // ĐÃ XÓA: biến này không được sử dụng

  final ApiService apiService = ApiService(baseUrl: AppConstants.baseUrl, client: client);

  final AiRemoteDataSource aiRemoteDataSource = AiRemoteDataSourceImpl(apiService: apiService); 
  final AiRepository aiRepository = AiRepositoryImpl(remoteDataSource: aiRemoteDataSource);

  runApp(MyApp(
    appRouter: AppRouter(),
    aiRepository: aiRepository,
  ));
}

// Giữ nguyên toàn bộ phần MyApp gốc của bạn
class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final AiRepository aiRepository;

  const MyApp({
    super.key,
    required this.appRouter,
    required this.aiRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(aiRepository: aiRepository),
        ),
        BlocProvider<LabResultAnalyzerBloc>(
          create: (context) => LabResultAnalyzerBloc(aiRepository: aiRepository),
        ),
        BlocProvider<SymptomAnalyzerBloc>(
          create: (context) => SymptomAnalyzerBloc(aiRepository: aiRepository),
        ),
        BlocProvider<PrescriptionBloc>(
          create: (context) => PrescriptionBloc(aiRepository: aiRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Doctor AI App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
      ),
    );
  }
}