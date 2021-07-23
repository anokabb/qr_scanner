import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:qr_scanner/cubit/internet_cubit.dart';
import 'package:qr_scanner/models/AdsUnitId.dart';

class MyBanner extends StatelessWidget {
  const MyBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: BannerAd(
              unitId: AdsUnitID.BannerUnitID,
              size: BannerSize.ADAPTIVE,
            ),
          );
        } else {
          return Container(height: 0);
        }
      },
    );
  }
}
