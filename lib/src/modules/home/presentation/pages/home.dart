import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/home/presentation/widgets/dashboard_card.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 16,
          children: [
            Text(
              'Resumo',
              style: textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                DashboardCard(
                  crossAxisCellCount: 1,
                  icon: Icons.book,
                  title: "Receitas",
                  subtitle: "Total de receitas:",
                  value: context.watch<RecipesProvider>().count.toString(),
                ),
                DashboardCard(
                  crossAxisCellCount: 1,
                  icon: Icons.kitchen,
                  title: "Ingredientes",
                  subtitle: "Total",
                  value: context.watch<IngredientsProvider>().count.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
