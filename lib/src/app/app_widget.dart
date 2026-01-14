import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/app/router/app_router.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/core/constants/app_constants.dart';
import 'package:reseller/src/core/theme/app_theme.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository_mock.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => IngredientsProvider()),
        ChangeNotifierProvider(
          create: (ctx) {
            final provider = RecipesProvider(RecipesRepositoryMock());
            provider.load();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,

        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        //darkTheme: AppTheme.dark,
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: Routes.mainShell,
      ),
    );
  }
}
