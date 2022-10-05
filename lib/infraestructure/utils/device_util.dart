// Flutter imports:
import 'dart:io';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';



// BuildMode of the app
enum BuildMode { DEBUG, PROFILE, RELEASE }

class DeviceUtil {

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }

    return false;
  }

  //Returns the device info if the device is an Android device.
  static Future<AndroidDeviceInfo> androidDeviceInfo() async {
    var plugin = DeviceInfoPlugin();
    return plugin.androidInfo;
  }

  //Returns the device info if the device is an iOS device.
  static Future<IosDeviceInfo> iosDeviceInfo() async {
    var plugin = DeviceInfoPlugin();
    return plugin.iosInfo;
  }


  // To select the build mode of the app
  static BuildMode currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.RELEASE;
    }
    var result = BuildMode.PROFILE;
    assert(() {
      result = BuildMode.DEBUG;
      return true;
    }());
    return result;
  }

}
