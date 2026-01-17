import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reseller/src/app/app_widget.dart';
import 'package:reseller/src/core/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar banco de dados
  await AppDatabase().database;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const AppWidget());
  });
}
