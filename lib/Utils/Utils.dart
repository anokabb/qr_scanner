import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/Utils/Localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static rateApp(BuildContext context, {required Function() action}) async {
    double rating = 4.5;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rated = prefs.getBool('rated');

    if (rated == null || rated == false) {
      bool res = await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (cnt) {
            return StatefulBuilder(builder: (_, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Card(
                        elevation: 10,
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate(context, 'rating_title'),
                                style: TextStyle(
                                    color: Theme.of(context).splashColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: RatingBar.builder(
                                      initialRating: 4.5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      glowColor: Theme.of(context).primaryColor,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onRatingUpdate: (v) {
                                        log(v.toString());
                                        rating = v;
                                      },
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      Navigator.pop(cnt);
                                    },
                                    child: Text(
                                      translate(context, 'cancel'),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      print(rating);
                                      if (rating >= 3) {
                                        prefs.setBool('rated', true);
                                        Navigator.pop(cnt);
                                        launch(
                                            'https://play.google.com/store/apps/details?id=com.akdev.qrscanner');
                                      } else if (rating > 0) {
                                        Navigator.pop(cnt);
                                      }
                                    },
                                    child: Text(
                                      translate(context, 'submit'),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              );
            });
          });

      return res;
    } else if (rated == true) {
      action();
    }
  }
}
