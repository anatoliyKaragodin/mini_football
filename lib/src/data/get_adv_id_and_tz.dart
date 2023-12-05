import 'package:flutter/foundation.dart';

import '../../main.dart';
import '../utils/library.dart';

class GetAdvIdAndTZ {
  /// Get advertisingId
  initPlatformState() async {
    // String? advertisingId;
    bool? isLimitAdTrackingEnabled;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      advertisingId = await AdvertisingId.id(true);
      if (kDebugMode) {
        print(advertisingId);
      }
    } on PlatformException {
      advertisingId = '';
    }
    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled;
    } on PlatformException {
      isLimitAdTrackingEnabled = false;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _advertisingId = advertisingId;
    //   // _isLimitAdTrackingEnabled = isLimitAdTrackingEnabled;
    // });
  }

  /// Get timezone
  Future<void> initTimeZone() async {
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
      if (kDebugMode) {
        print(timezone);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Could not get the local timezone');
      }
    }
  }
}
