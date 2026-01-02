import 'package:flutter/material.dart';
import 'package:reseller/src/core/constants/app_constants.dart';
import 'package:reseller/src/modules/home/presentation/pages/home.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          background: AppColors.background,
          primary: AppColors.accent,
          onBackground: AppColors.primaryText,
        ),
        textTheme: Typography.blackMountainView.apply(
          bodyColor: AppColors.primaryText,
          displayColor: AppColors.primaryText,
        ),
      ),
      home: const Home(),
    );
  }
}


/*
No futuro deve ser padronizado para seguir o exemplo abaixo:

import 'package:estudo_app/core/constants/app_constants.dart';
import 'package:estudo_app/core/theme/app_theme.dart';
import 'package:estudo_app/screens/clock.dart';
import 'package:estudo_app/screens/home.dart';
import 'package:estudo_app/screens/image.dart';
import 'package:estudo_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppConstants.loginRoute,
      routes: {
        AppConstants.loginRoute: (context) => const LoginScreen(),
        AppConstants.homeRoute: (context) => const HomeScreen(),
        AppConstants.clockRoute: (context) => const ClockScreen(),
        AppConstants.imageRoute: (context) => const ImageScreen(),
      },
    );
  }
}

Onde sera criado um arquivo app_theme.dart em /core/theme/app_theme.dart para gerenciar os temas

E sera organizado as rotas no routes.dart em /core/constants/routes.dart

 */