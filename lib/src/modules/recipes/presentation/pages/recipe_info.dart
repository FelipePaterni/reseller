import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/table_tab.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/top_image.dart';
import 'package:reseller/src/shared/widgets/draggable_bottom.dart';
import 'package:reseller/src/shared/widgets/tab_item.dart';

class RecipeInfo extends StatefulWidget {
  const RecipeInfo({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              TopImage(imagePath: widget.recipe.imagePath),
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
              DraggableBottom(
                widget.recipe.name,
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
                          TableTab(
                            scrollController: scrollController,
                            items: widget.recipe.items,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
