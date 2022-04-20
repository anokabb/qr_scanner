import 'dart:io';

class AdsUnitID {
  /// ***** Test Android Ads *******/
  static const String AndroidBannerUnitID =
      'ca-app-pub-3940256099942544/6300978111';
  static const String AndroidInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const String AndroidNativeAdUnitID =
      'ca-app-pub-3940256099942544/2247696110';

  // /// ***** Test IOS Ads *******/
  // static const String IOSBannerUnitID =
  //     'ca-app-pub-3940256099942544/2934735716';
  // static const String IOSNativeAdUnitID =
  //     'ca-app-pub-3940256099942544/3986624511';
  // static const String IOSInterstitial =
  //     'ca-app-pub-3940256099942544/4411468910';

  /// ***** Android Ads *******/
  // static const String AndroidBannerUnitID =
  //     'ca-app-pub-9745500678773453/3503849670';
  // static const String AndroidInterstitial =
  //     'ca-app-pub-9745500678773453/5912838205';
  // static const String AndroidNativeAdUnitID =
  //     'ca-app-pub-9745500678773453/9054369886';

  // ***** IOS Ads *******/
  static const String IOSBannerUnitID =
      'ca-app-pub-9745500678773453/4978705455';
  static const String IOSInterstitial =
      'ca-app-pub-9745500678773453/8433900588';
  static const String IOSNativeAdUnitID =
      'ca-app-pub-9745500678773453/8785076769';

  static String get InterstitialUnitID => Platform.isIOS
      ? IOSInterstitial
      : Platform.isAndroid
          ? AndroidInterstitial
          : "";
  static String get BannerUnitID => Platform.isIOS
      ? IOSBannerUnitID
      : Platform.isAndroid
          ? AndroidBannerUnitID
          : "";
  static String get NativeUnitID => Platform.isIOS
      ? IOSNativeAdUnitID
      : Platform.isAndroid
          ? AndroidNativeAdUnitID
          : "";
}
