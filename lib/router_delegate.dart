import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';
import 'home_page.dart';
import 'login_page.dart';

class MyAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  bool _loggedIn;
  bool get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

  final AppConfig config;
  final FlutterSecureStorage storage;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate(this.config, this.storage)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    var token = await this.storage.read(key: "token");
    loggedIn = token != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    // if (loggedIn == null) {
    //   stack = _splashStack;
    // } else if (loggedIn) {
    if (loggedIn) {
      stack = _loggedInStack;
    } else {
      stack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  // List<Page> get _splashStack =>
  //     [SplashPage(process: 'Splash Screen:\n\nChecking auth state')];

  List<Page> get _loggedOutStack => [
        LoginPage(config, storage, onLogin: () {
          loggedIn = true;
        })
      ];

  List<Page> get _loggedInStack {
    final onLogout = () async {
      await this.storage.delete(key: "token");
      loggedIn = false;
    };
    return [
      HomePage(
        onLogout: onLogout,
      ),
    ];
  }

  @override
  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
