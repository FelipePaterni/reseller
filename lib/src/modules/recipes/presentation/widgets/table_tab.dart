import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/core/theme/app_texts.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/recipe_item_edit_sheet.dart';

class TableTab extends StatelessWidget {
  final ScrollController scrollController;
  final List<RecipeItem> items;
  final String recipeId;

  const TableTab.ingredient({
    super.key,
    required this.scrollController,
    required this.items,
    required this.recipeId,
  });

  void _showEditSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RecipeItemEditSheet(
        recipeId: recipeId,
        recipeItem: items[index],
        itemIndex: index,
        currentItems: items,
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context, int index) async {
    final recipesProvider = Provider.of<RecipesProvider>(
      context,
      listen: false,
    );

    try {
      await recipesProvider.removeRecipeItem(recipeId, index);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingrediente removido com sucesso')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao remover: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ingredientes',
                style: AppTexts.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Quantidade',
                style: AppTexts.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Opções',
                style: AppTexts.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: items.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum ingrediente adicionado',
                    style: AppTexts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              items[index].ingredient.name,
                              style: AppTexts.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${items[index].quantity} ${items[index].ingredient.unitLabel}',
                              style: AppTexts.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.brandAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    iconSize: 16,
                                    padding: EdgeInsets.zero,
                                    onPressed: () =>
                                        _showEditSheet(context, index),
                                    icon: const Icon(Icons.edit),
                                    color: AppColors.surface,
                                  ),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.brandAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    iconSize: 16,
                                    padding: EdgeInsets.zero,
                                    onPressed: () =>
                                        _deleteItem(context, index),
                                    icon: const Icon(Icons.delete),
                                    color: AppColors.surface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
