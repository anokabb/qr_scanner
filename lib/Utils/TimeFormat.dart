import 'package:flutter/cupertino.dart';

import 'package:qr_scanner/models/Languages.dart';

import 'Localization/app_localizations.dart';

class TimeFormat {
  final int timestamp;
  final String langCode;
  final BuildContext context;
  TimeFormat({
    required this.timestamp,
    required this.langCode,
    required this.context,
  });

  String formatTime() {
    int difference = DateTime.now().millisecondsSinceEpoch - timestamp;
    String result;

    if (difference < 60000) {
      result = countSeconds(difference);
    } else if (difference < 3600000) {
      result = countMinutes(difference);
    } else if (difference < 86400000) {
      result = countHours(difference);
    } else if (difference < 604800000) {
      result = countDays(difference);
    } else if (difference / 1000 < 2419200) {
      result = countWeeks(difference);
    } else if (difference / 1000 < 31536000) {
      result = countMonths(difference);
    } else
      result = countYears(difference);

    if (langCode == Languages.ENGLISH_STR) {
      return !result.startsWith("J") ? result + ' ago' : result;
    } else if (langCode == Languages.FRENCH_STR) {
      return !result.startsWith("M") ? "il ya " + result : result;
    } else if (langCode == Languages.ARABIC_STR) {
      return result;
    } else {
      return !result.startsWith("J") ? result + ' ago' : result;
    }
  }

  /// Converts the time difference to a number of seconds.
  /// This function truncates to the lowest second.
  ///   returns ("Just now" OR "X seconds")
  String countSeconds(int difference) {
    int count = (difference / 1000).truncate();

    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count < 1) {
        return res = 'الآن';
      } else if (count == 1) {
        res = ' ثانية';
      } else if (count == 2) {
        res = ' ثانيتين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' ثوان';
      } else {
        res = count.toString() + ' ثانية';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      return count > 1
          ? count.toString() + ' ' + translate(context, 'seconds')
          : translate(context, 'justNow');
    }
  }

  /// Converts the time difference to a number of minutes.
  /// This function truncates to the lowest minute.
  ///   returns ("1 minute" OR "X minutes")
  String countMinutes(int difference) {
    int count = (difference / 60000).truncate();
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' دقيقة';
      } else if (count == 2) {
        res = ' دقيقتين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' دقائق';
      } else {
        res = count.toString() + ' دقيقة';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      return count.toString() +
          ' ' +
          (count > 1
              ? translate(context, 'minutes')
              : translate(context, 'minute'));
    }
  }

  /// Converts the time difference to a number of hours.
  /// This function truncates to the lowest hour.
  ///   returns ("1 hour" OR "X hours")
  String countHours(int difference) {
    int count = (difference / 3600000).truncate();
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' ساعة';
      } else if (count == 2) {
        res = ' ساعتين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' ساعات';
      } else {
        res = count.toString() + ' ساعة';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      return count.toString() +
          ' ' +
          (count > 1
              ? translate(context, 'hours')
              : translate(context, 'hour'));
    }
  }

  /// Converts the time difference to a number of days.
  /// This function truncates to the lowest day.
  ///   returns ("1 day" OR "X days")
  String countDays(int difference) {
    int count = (difference / 86400000).truncate();
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' يوم';
      } else if (count == 2) {
        res = ' يومان';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' أيام';
      } else {
        res = count.toString() + ' يوم';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      return count.toString() +
          ' ' +
          (count > 1 ? translate(context, 'days') : translate(context, 'day'));
    }
  }

  /// Converts the time difference to a number of weeks.
  /// This function truncates to the lowest week.
  ///   returns ("1 week" OR "X weeks" OR "1 month")
  String countWeeks(int difference) {
    int count = (difference / 604800000).truncate();
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' أسبوع';
      } else if (count == 2) {
        res = ' اسبوعين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' أسابيع';
      } else {
        res = count.toString() + ' أسبوع';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      if (count > 3) {
        return '1 ' + translate(context, 'month');
      }
      return count.toString() +
          ' ' +
          (count > 1
              ? translate(context, 'weeks')
              : translate(context, 'week'));
    }
  }

  /// Converts the time difference to a number of months.
  /// This function rounds to the nearest month.
  ///   returns ("1 month" OR "X months" OR "1 year")
  String countMonths(int difference) {
    int count = (difference / 2628003000).round();
    count = count > 0 ? count : 1;
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' شهر';
      } else if (count == 2) {
        res = ' شهرين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' أشهر';
      } else {
        res = count.toString() + ' شهر';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      if (count > 12) {
        return '1 ' + translate(context, 'year');
      }
      return count.toString() +
          ' ' +
          (count > 1
              ? translate(context, 'months')
              : translate(context, 'month'));
    }
  }

  /// Converts the time difference to a number of years.
  /// This function truncates to the lowest year.
  ///   returns ("1 year" OR "X years")
  String countYears(int difference) {
    int count = (difference / 31536000000).truncate();
    if (langCode == Languages.ARABIC_STR) {
      String res;
      if (count == 1) {
        res = ' سنة';
      } else if (count == 2) {
        res = ' عامين';
      } else if (count > 2 && count < 11) {
        res = count.toString() + ' سنوات';
      } else {
        res = count.toString() + ' سنة';
      }
      res = 'قبل ' + res;
      return res;
    } else {
      return count.toString() +
          ' ' +
          (count > 1
              ? translate(context, 'years')
              : translate(context, 'year'));
    }
  }
}
