import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/core/theme/app_texts.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

class TableTab extends StatelessWidget {
  final ScrollController scrollController;
  final List<RecipeItem> items;

  const TableTab({
    super.key,
    required this.scrollController,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 9, right: 9, top: 20, bottom: 0),
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
          flex: 3,
          child: ListView.builder(
            controller: scrollController,
            itemCount: items.length,

            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        items[index].ingredient.name,
                        style: AppTexts.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
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
                        mainAxisAlignment: MainAxisAlignment.end,
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
                              onPressed: () {},
                              icon: const Icon(Icons.close),
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
