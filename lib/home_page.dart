import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen.dart';

import 'home_screen.dart';

class HomePage extends Page {
  
  final VoidCallback onLogout;

  HomePage({@required this.onLogout}) : super(key: ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(onLogout: onLogout),
    );
  }
}
