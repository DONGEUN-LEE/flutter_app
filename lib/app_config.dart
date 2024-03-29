import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrlAndroid;
  final String apiUrlIos;

  AppConfig({this.apiUrlAndroid, this.apiUrlIos});

  static Future<AppConfig> forEnvironment(String env) async {
    // set default to dev if nothing was passed
    env = env ?? 'dev';

    // load the json file
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    return AppConfig(apiUrlAndroid: json['apiUrlAndroid'], apiUrlIos: json['apiUrlIos']);
  }
}
