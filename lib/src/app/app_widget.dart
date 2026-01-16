import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/app/router/app_router.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/core/constants/app_constants.dart';
import 'package:reseller/src/core/theme/app_theme.dart';
import 'package:reseller/src/modules/ingredients/data/datasource/ingredients_local_datasource_impl.dart';
import 'package:reseller/src/modules/ingredients/data/repositories/ingredients_repository_impl.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/recipes/data/datasource/recipes_local_datasource_impl.dart';
import 'package:reseller/src/modules/recipes/data/repositories/recipes_repository_impl.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            // Ingredients: DataSource → Repository → Provider
            final ingredientsDataSource = IngredientsLocalDataSourceImpl();
            final ingredientsRepository = IngredientsRepositoryImpl(
              dataSource: ingredientsDataSource,
            );
            final provider = IngredientsProvider(ingredientsRepository);
            provider.load();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            // Recipes: DataSource → Repository → Provider
            final recipesDataSource = RecipesLocalDataSourceImpl();
            final recipesRepository = RecipesRepositoryImpl(
              dataSource: recipesDataSource,
            );
            final provider = RecipesProvider(recipesRepository);
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
