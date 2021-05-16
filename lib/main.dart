import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';
import 'router_delegate.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // load our config
  final config = await AppConfig.forEnvironment(env);
  final storage = new FlutterSecureStorage();
  final delegate = new MyAppRouterDelegate(config, storage);

  runApp(MyApp(config, storage, delegate));
}

class MyApp extends StatelessWidget {
  MyApp(this.config, this.storage, this.delegate);

  final AppConfig config;
  final FlutterSecureStorage storage;
  final MyAppRouterDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(routerDelegate: delegate)
        );
  }
}
