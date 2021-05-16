import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.onLogin, this.title, this.config, this.storage})
      : super(key: key);

  final VoidCallback onLogin;
  final String title;
  final AppConfig config;
  final FlutterSecureStorage storage;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (text) {
                  setState(() {
                    _email = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: (text) {
                  setState(() {
                    _password = text;
                  });
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Uri url;
                  switch (foundation.defaultTargetPlatform) {
                    case foundation.TargetPlatform.android:
                      String urlAndroid = this.widget.config.apiUrlAndroid;
                      url = Uri.parse('$urlAndroid/api/login');
                      break;
                    default:
                      String urlIos = this.widget.config.apiUrlIos;
                      url = Uri.parse('$urlIos/api/login');
                      break;
                  }
                  if (url != null) {
                    var response = await http.post(url,
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode(
                            {"email": _email, "password": _password}));
                    var result = jsonDecode(response.body);
                    if (result['message'] == 'Success') {
                      await this
                          .widget
                          .storage
                          .write(key: "token", value: result['token']);
                      this.widget.onLogin();
                    }
                  }
                },
                child: Text('Sign In')),
          ],
        ),
      ),
    );
  }
}
