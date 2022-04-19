import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/cubit/internet_cubit.dart';
import 'package:qr_scanner/models/AdsUnitId.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyBanner extends StatelessWidget {
  final Color? background;

  final BannerAd myBanner = BannerAd(
    adUnitId: AdsUnitID.BannerUnitID,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  MyBanner({Key? key, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myBanner.load();
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected) {
          return Container(
            color: background ?? Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: AdWidget(ad: myBanner),
            width: double.infinity,
            height: myBanner.size.height.toDouble(),
          );
        } else {
          return SizedBox(height: 0);
        }
      },
    );
  }
}
