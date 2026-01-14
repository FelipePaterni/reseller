import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/table_tab.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/top_image.dart';
import 'package:reseller/src/shared/widgets/draggable_bottom.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/tab_item.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/recipe_item_edit_sheet.dart';

class RecipeInfo extends StatefulWidget {
  const RecipeInfo({super.key, required this.recipeId});
  final String recipeId;

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  void _showAddRecipeItemSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RecipeItemEditSheet(
        recipeId: widget.recipeId,
        currentItems: context
            .read<RecipesProvider>()
            .getById(widget.recipeId)
            .items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Recipe recipe;
    try {
      recipe = context.watch<RecipesProvider>().getById(widget.recipeId);
    } catch (e) {
      return Scaffold(
        appBar: AppBar(title: const Text("Receita não encontrada")),
        body: const Center(
          child: Text("A receita solicitada não foi encontrada."),
        ),
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddRecipeItemSheet,
          tooltip: 'Adicionar ingrediente',
          child: const Icon(Icons.add),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              TopImage(imagePath: recipe.imagePath),
              SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.brandAccent,
                  ),
                  icon: Icon(Icons.arrow_back),
                  alignment: Alignment.topLeft,
                  color: AppColors.textInverted,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(0, 0, 0, 0),
                      Theme.of(context).shadowColor,
                    ],
                    stops: const [0.3, 0.7],
                  ),
                ),
                child: DraggableBottom(
                  recipe.name,
                  builder: (scrollController) => [
                    PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(19)),
                          color: AppColors.surfaceVariant,
                        ),
                        child: TabBar(
                          padding: const EdgeInsets.all(6),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          tabs: [
                            TabItem(title: 'Informações'),
                            TabItem(title: 'Ingredientes'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TabBarView(
                          children: [
                            Text("EM construction"),
                            TableTab.ingredient(
                              scrollController: scrollController,
                              items: recipe.items,
                              recipeId: widget.recipeId,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
