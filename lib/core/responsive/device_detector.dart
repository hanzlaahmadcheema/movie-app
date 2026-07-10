import 'dart:io';
import 'package:flutter/foundation.dart';

class DeviceDetector {
  DeviceDetector._privateConstructor();

  static final DeviceDetector instance = DeviceDetector._privateConstructor();

  // For now, this is a mock implementation.
  // In a real app, you would use platform channels to check the UiModeManager on Android.
  bool get isTv {
    if (kIsWeb) return false;
    // Just a placeholder. You can toggle this for testing.
    return false;
  }
}
