import 'dart:io';

import 'package:flutter/foundation.dart';

enum CustomPlatform{
  windows,
  linux,
  macos,
  ios,
  android,
  web,
  fuchsia,
  another;

  @override
  String toString(){
    switch (index){
      case 0:
        return 'windows'.toUpperCase();
      case 1:
        return 'linux'.toUpperCase();
      case 2:
        return 'macos'.toUpperCase();
      case 3:
        return 'ios'.toUpperCase();
      case 4:
        return 'android'.toUpperCase();
      case 5:
        return 'web'.toUpperCase();
      case 6:
        return 'fuchsia'.toUpperCase();
      default:
        return name.toString().toUpperCase();
    }
  }

}

class AppPlatform {

  static CustomPlatform _checkPlatform() {
    if (kIsWeb) {
      return CustomPlatform.web;
    } else if (Platform.isWindows) {
      return CustomPlatform.windows;
    } else if (Platform.isAndroid) {
      return CustomPlatform.android;
    } else if (Platform.isIOS) {
      return CustomPlatform.ios;
    } else if (Platform.isFuchsia) {
      return CustomPlatform.fuchsia;
    } else {
      return CustomPlatform.another;
    }
  }

  static CustomPlatform get platform => _checkPlatform();
}