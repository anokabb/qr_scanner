import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import '../models/AdsUnitId.dart';

Widget separatorBuilder(
  BuildContext context,
  int index,
) {
  NativeAd _bigAd = fullNativeAd(context);
  NativeAd _smallAd = smallNativeAd(context);
  return index == 0
      ? _bigAd
      : index % 6 == 0
          ? _smallAd
          : Container();
}

NativeAd fullNativeAd(BuildContext context, {double padding = 16}) {
  return NativeAd(
    height: 300,
    unitId: AdsUnitID.NativeAdUnitID,
    builder: (context, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: child,
      );
    },
    buildLayout: (ratingBar, media, icon, headline, advertiser, body, price,
        store, attribuition, button) {
      return AdLinearLayout(
        padding: EdgeInsets.all(10),
        width: MATCH_PARENT,
        decoration: AdDecoration(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        children: [
          media,
          AdLinearLayout(
            children: [
              icon,
              AdLinearLayout(children: [
                headline,
                AdLinearLayout(
                  children: [attribuition, advertiser, ratingBar],
                  orientation: HORIZONTAL,
                  width: MATCH_PARENT,
                ),
              ], margin: EdgeInsets.only(left: 4)),
            ],
            gravity: LayoutGravity.center_horizontal,
            width: WRAP_CONTENT,
            orientation: HORIZONTAL,
            margin: EdgeInsets.only(top: 6),
          ),
          AdLinearLayout(
            children: [button],
            orientation: HORIZONTAL,
          ),
        ],
      );
    },
    icon: AdImageView(size: 40),
    headline: AdTextView(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      maxLines: 1,
    ),
    media: AdMediaView(
      height: 180,
      width: MATCH_PARENT,
      elevation: 6,
      elevationColor: Colors.deepPurpleAccent,
    ),
    attribution: AdTextView(
      width: WRAP_CONTENT,
      height: WRAP_CONTENT,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      margin: EdgeInsets.only(right: 4),
      maxLines: 1,
      // text: 'Anúncio',
      decoration: AdDecoration(
        borderRadius: AdBorderRadius.all(10),
        border: BorderSide(color: Colors.green, width: 1),
      ),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    button: AdButtonView(
      elevation: 18,
      elevationColor: Colors.amber,
      height: MATCH_PARENT,
    ),
  );
}

NativeAd smallNativeAd(BuildContext context, {double padding = 16}) {
  return NativeAd(
    unitId: AdsUnitID.NativeAdUnitID,
    height: 100,
    builder: (context, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: child,
      );
    },
    buildLayout: (ratingBar, media, icon, headline, advertiser, body, price,
        store, attribution, button) {
      return AdLinearLayout(
        padding: EdgeInsets.all(10),
        // The first linear layout width needs to be extended to the
        // parents height, otherwise the children won't fit good
        width: MATCH_PARENT,
        orientation: HORIZONTAL,
        decoration: AdDecoration(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        children: [
          icon,
          AdLinearLayout(
            children: [
              headline,
              AdLinearLayout(
                children: [attribution, advertiser, ratingBar],
                orientation: HORIZONTAL,
                width: WRAP_CONTENT,
                height: 20,
              ),
              button,
            ],
            margin: EdgeInsets.symmetric(horizontal: 4),
          ),
        ],
      );
    },
    icon: AdImageView(size: 80),
    headline: AdTextView(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      maxLines: 1,
    ),
    media: AdMediaView(height: 80, width: 120),
  );
}
