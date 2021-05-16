import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';
import 'login_screen.dart';

class LoginPage extends Page {
  final VoidCallback onLogin;
  final AppConfig config;
  final FlutterSecureStorage storage;

  LoginPage(this.config, this.storage, {@required this.onLogin})
      : super(key: ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => LoginScreen(
          onLogin: onLogin,
          title: 'Login Page',
          config: config,
          storage: storage),
    );
  }
}
