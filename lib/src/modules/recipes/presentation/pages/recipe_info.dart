import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
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

class _RecipeInfoState extends State<RecipeInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddRecipeItemSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RecipeItemEditSheet(
        recipeId: widget.recipeId,
        currentItems:
            context.read<RecipesProvider>().getById(widget.recipeId)?.items ??
            [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = context.watch<RecipesProvider>().getById(widget.recipeId);

    if (recipe == null) {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            style: IconButton.styleFrom(backgroundColor: AppColors.brandAccent),
            icon: Icon(Icons.arrow_back),
            alignment: Alignment.topLeft,
            color: AppColors.textInverted,
          ),
        ),
        floatingActionButton: _tabController.index == 1
            ? FloatingActionButton(
                onPressed: _showAddRecipeItemSheet,
                tooltip: 'Adicionar ingrediente',
                child: const Icon(Icons.add),
              )
            : null,
        body: SizedBox.expand(
          child: Stack(
            children: [
              TopImage(imagePath: recipe.imagePath),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.scrim.withAlpha(0),
                      Theme.of(context).colorScheme.scrim,
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
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          padding: const EdgeInsets.all(6),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          onTap: (index) {
                            setState(() {});
                          },
                          tabs: [
                            TabItem(title: 'Informações'),
                            TabItem(title: 'Ingredientes'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TabBarView(
                          controller: _tabController,
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
