import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:stunning_tribble/config/config_model.dart';

class ConfigReader {
  static ConfigModel _config =
      ConfigModel(API_HOST: "API_HOST", DEBUG: false, TESTING: false);

  static Future<void> initializeApp(String? env) async {
    env = env ?? "development";
    final configString = await rootBundle.loadString('assets/config/env.json');
    final jsonMap = json.decode(configString);
    _config = ConfigModel.fromMap(jsonMap[env]);
  }

  static ConfigModel config() {
    return _config;
  }
}
