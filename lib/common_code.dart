import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class getdata {
  static String? userid;
  static String? deviceid;

  Future<void> _logEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'test_event',
    );
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "LOgin");
  }

  static getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id.toString();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor.toString();
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      final windowss = await deviceInfo.webBrowserInfo;
      deviceId = windowss.toString();
    } else {
      deviceId = 'unknown_device';
    }
    deviceid = deviceId;
    return deviceId;
  }

  static void reportError(dynamic message, StackTrace? stackTrace,
      [String? userId, String? deviceId]) async {
    print(
        "messege: $message, StackTrace: ${stackTrace.toString()}, userId: ${userId}, deviceid: ${deviceId}");
    final crashlytics = FirebaseCrashlytics.instance;
    crashlytics.setUserIdentifier(userId ?? getuserid());
    crashlytics.setCustomKey('DeviceId', await getDeviceId());
    crashlytics.recordError(message, stackTrace);
  }

  static getuserid() {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'unknown_user';
    if (user != null) {
      userid = userId;
      return userId;
    } else {
      userid = userId;
      return userId;
    }
  }
}
