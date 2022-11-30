import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FlutterHelpScout {
  static const MethodChannel _channel =
      const MethodChannel('kelvinforteta.dev/flutter_help_scout');

  /// This is your beacon ID
  dynamic beaconId;

  /// This is the user's name
  final String name;

  /// This is the user's email address
  final String email;

  /// This is the user's avatar/photo
  final String avatar;

  /// This is the user's company
  final String company;

  /// This is the user's job title
  final String jobTitle;

  FlutterHelpScout(
      {this.email = '',
      this.name = '',
      this.beaconId,
      this.avatar = '',
      this.company = '',
      this.jobTitle = ''});

  /// This method will initialize the beacon.
  Future<void> initialize() async {
    var data = <String, dynamic>{
      'beaconId': beaconId,
      'email': email,
      'name': name,
      'avatar': avatar,
      'jobTitle': jobTitle,
      'company': company,
    };

    try {
      var result = await _channel.invokeMethod(
        'initialize',
        data,
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to initialize beacon: ${e.toString()}');
    }
  }

  /// Once you’ve initialized Beacon, you’re ready to interact with it.
  /// Whenever you want to invoke Beacon, use the code below to
  /// display the Beacon user interface.

  Future<void> open({dynamic beaconId}) async {
    var data = <String, dynamic>{
      'beaconId': beaconId,
    };

    try {
      var result = await _channel.invokeMethod(
        'openBeacon',
        data,
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }

  /// Calling this method resets the current Beacon state,
  /// thereby deleting all the user data: email, name, user attributes,
  /// push token and resets the Beacon Device ID. It won’t
  /// remove the Beacon ID, or any local config overrides.

  Future<void> logout() async {
    try {
      var result = await _channel.invokeMethod(
        'logoutBeacon',
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }

  /// This method wipes all data from the Beacon,
  /// including the Beacon ID. This may be useful if
  /// you are using different Beacons in different parts of your app.

  Future<void> clear() async {
    try {
      var result = await _channel.invokeMethod(
        'clearBeacon',
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }
}
