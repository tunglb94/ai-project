// lib/core/services/rewarded_ad_manager.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart'; // Giữ lại import này vì nó cần thiết cho việc khởi tạo

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  final String adUnitId;
  Completer<bool>? _adLoadCompleter;

  // Constructor
  RewardedAdManager({required this.adUnitId});

  // Tải quảng cáo có thưởng
  void loadRewardedAd() {
    if (_isAdLoaded) {
      debugPrint('Rewarded Ad for $adUnitId already loaded.');
      _adLoadCompleter?.complete(true);
      return;
    }
    if (_adLoadCompleter != null && !_adLoadCompleter!.isCompleted) {
      _adLoadCompleter!.complete(false);
    }
    _adLoadCompleter = Completer<bool>();

    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          debugPrint('Rewarded Ad for $adUnitId loaded.');
          _setFullScreenContentCallback();
          if (!_adLoadCompleter!.isCompleted) {
            _adLoadCompleter!.complete(true);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Rewarded Ad for $adUnitId failed to load: $error');
          _isAdLoaded = false;
          if (!_adLoadCompleter!.isCompleted) {
            _adLoadCompleter!.complete(false);
          }
        },
      ),
    );
  }

  // Đặt callback cho các sự kiện của quảng cáo toàn màn hình
  void _setFullScreenContentCallback() {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _rewardedAd = null;
        _isAdLoaded = false;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _rewardedAd = null;
        _isAdLoaded = false;
        loadRewardedAd();
      },
    );
  }

  // Hiển thị quảng cáo có thưởng với cơ chế timeout/fallback
  Future<void> showRewardedAd({
    required BuildContext context,
    required Function() onAdWatchedReward,
    required Function() onAdFailed,
    Duration timeout = const Duration(seconds: 8),
  }) async {
    if (_rewardedAd != null && _isAdLoaded) {
      _rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          debugPrint('User earned reward: ${rewardItem.amount} ${rewardItem.type}');
          onAdWatchedReward();
        },
      );
      if (_adLoadCompleter != null && !_adLoadCompleter!.isCompleted) {
        _adLoadCompleter!.complete(true);
      }
    } else {
      // Quảng cáo chưa sẵn sàng, hiển thị hộp thoại chờ
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Đang tải quảng cáo...'),
              content: const Column(
                mainAxisSize: MainAxisSize.min, // Dòng này ĐÃ CHÍNH XÁC
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Vui lòng đợi trong giây lát hoặc nhấn Bỏ qua.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                    onAdFailed();
                  },
                  child: const Text('Bỏ qua'),
                ),
              ],
            ),
          );
        },
      );

      try {
        bool success = await (_adLoadCompleter?.future ?? Future.value(false)).timeout(timeout);

        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop();

        if (success && _rewardedAd != null) {
          _rewardedAd?.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              debugPrint('User earned reward: ${rewardItem.amount} ${rewardItem.type}');
              onAdWatchedReward();
            },
          );
        } else {
          debugPrint('Rewarded Ad did not load within timeout for $adUnitId.');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Không thể tải quảng cáo. Đã bỏ qua.')),
            );
          }
          onAdFailed();
        }
      } on TimeoutException {
        debugPrint('Rewarded Ad load timed out for $adUnitId.');
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tải quảng cáo quá lâu. Đã bỏ qua.')),
          );
        }
        onAdFailed();
      } catch (e) {
        debugPrint('Error waiting for rewarded ad: $e');
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã xảy ra lỗi khi tải quảng cáo. Đã bỏ qua.')),
          );
        }
        onAdFailed();
      }
    }
  }

  // Giải phóng tài nguyên quảng cáo khi không còn cần thiết
  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdLoaded = false;
    _adLoadCompleter?.complete(false);
  }
}