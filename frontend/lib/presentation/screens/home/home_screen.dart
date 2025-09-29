// home_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _topBannerAd;
  BannerAd? _bottomBannerAd;

  @override
  void initState() {
    super.initState();
    _loadTopBannerAd();
    _loadBottomBannerAd();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_topBannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _topBannerAd!.size.width.toDouble(),
                height: _topBannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _topBannerAd!),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chào bạn,',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bạn cần Doctor AI giúp gì hôm nay?',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // --- GRID VIEW ĐÃ ĐƯỢC CẬP NHẬT TEXT ---
                  const _FeatureGrid(),
                  
                  const SizedBox(height: 24),
                  const _AiCharacterBanner(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
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

// Widget lưới chức năng với nội dung đã được cập nhật
class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: const [
        _FeatureCard(
          title: 'Trò chuyện với Doctor AI',
          subtitle: 'Hỏi đáp & Tư vấn',
          icon: Icons.chat_bubble_rounded,
          route: '/chat',
          startColor: Color(0xFF4481EB),
          endColor: Color(0xFF04BEFE),
        ),
        _FeatureCard(
          title: 'Chuẩn đoán bệnh',
          subtitle: 'Dựa trên triệu chứng',
          icon: Icons.sick_rounded,
          route: '/symptom',
          startColor: Color(0xFF42E695),
          endColor: Color(0xFF3BB2B8),
        ),
        _FeatureCard(
          title: 'Kê đơn',
          subtitle: 'Kê đơn thuốc và giá tham khảo',
          icon: Icons.medication_liquid_rounded,
          route: '/prescription',
          startColor: Color(0xFFFFB22C),
          endColor: Color(0xFFD95027),
        ),
        _FeatureCard(
          title: 'Đọc kết quả',
          subtitle: 'X-quang, đơn thuốc, MRI, Xét nghiệm...',
          icon: Icons.document_scanner_rounded,
          route: '/lab_result',
          startColor: Color(0xFFBA68C8),
          endColor: Color(0xFF7E57C2),
        ),
      ],
    );
  }
}

// Widget thẻ chức năng (không thay đổi)
class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final Color startColor;
  final Color endColor;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(route),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                      maxLines: 2, // Cho phép subtitle hiển thị 2 dòng
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget banner nhân vật AI (không thay đổi)
class _AiCharacterBanner extends StatelessWidget {
  const _AiCharacterBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào, tôi là Doctor AI.',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Luôn sẵn sàng hỗ trợ sức khỏe toàn diện cho bạn.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/doctor_character.jpg',
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}