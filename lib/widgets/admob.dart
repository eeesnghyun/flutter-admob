import 'dart:io';

import 'package:admob_example/constants/constants.dart';
import 'package:admob_example/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob extends StatelessWidget {
  final int width;
  final int height;

  Admob({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final AdSize adSize = AdSize(width: width, height: height);

    final BannerAdListener adListener = BannerAdListener(
      onAdLoaded: (Ad ad) => logger.i('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        logger.i('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => logger.i('Ad opened.'),
      onAdClosed: (Ad ad) => logger.i('Ad closed.'),
      onAdImpression: (Ad ad) => logger.i('Ad impression.'),
    );

    BannerAd banner = BannerAd(
      size: adSize,
      adUnitId: Platform.isIOS
          ? kDebugMode
              ? admobIosBottomTestBannerId
              : admobIosBottomBannerId
          : kDebugMode
              ? admobAndBottomTestBannerId
              : admobAndBottomBannerId,
      listener: adListener,
      request: const AdRequest(),
    )..load();

    return AdWidget(
      ad: banner,
    );
  }
}
