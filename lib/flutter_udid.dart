import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

/// API to retrieve a unique device ID of the device the Flutter
/// app is currently running on.
class FlutterUdid {
  static const MethodChannel _channel = MethodChannel('flutter_udid');

  /// Returns the UDID in the platform-specific format.
  /// iOS: 7946DA4E-8429-423C-B405-B3FC77914E3E,
  /// Android: 8af8770a27cfd182
  static Future<String> getUdid({
    String? bundleNameIos,
  }) async {
    final arguments = {
      if (bundleNameIos?.isNotEmpty == true) 'bundleName': bundleNameIos,
    };
    final String udid = await _channel.invokeMethod('getUDID', arguments);
    return udid;
  }

  /// Returns the UDID in a consistent format for all platforms.
  /// Example: 984725b6c4f55963cc52fca0f943f9a8060b1c71900d542c79669b6dc718a64b
  static Future<String> getConsistentUdid({
    String? bundleNameIos,
  }) async {
    final arguments = {
      if (bundleNameIos?.isNotEmpty == true) 'bundleName': bundleNameIos,
    };
    final String udid = await _channel.invokeMethod('getUDID', arguments);
    var bytes = utf8.encode(udid);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
