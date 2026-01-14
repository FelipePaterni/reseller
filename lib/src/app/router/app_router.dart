import 'package:flutter/material.dart';
import 'package:reseller/src/app/main_shell.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/modules/recipes/presentation/pages/recipe_info.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainShell:
        return _page(const MainShell());
      case Routes.recipesInfo:
        final recipeId = settings.arguments as String;
        return _page(RecipeInfo(recipeId: recipeId));
      default:
        return _page(null);
    }
  }

  static PageRoute _page(Widget? page) {
    if (page == null) {
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('Rota não encontrada'))),
      );
    }
    return MaterialPageRoute(builder: (_) => page);
  }
}
