import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reseller/src/app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const AppWidget());
  });
}
  