import 'package:flutter/material.dart';
import 'package:reseller/src/app/router/app_router.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/core/constants/app_constants.dart';
import 'package:reseller/src/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,

      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
      initialRoute: Routes.mainShell,
    );
  }
}
