import 'package:flutter/material.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/core/theme/app_texts.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/top_image.dart';
import 'package:reseller/src/shared/widgets/draggable_bottom.dart';
import 'package:reseller/src/shared/widgets/tab_item.dart';

class RecipeInfo extends StatefulWidget {
  const RecipeInfo({super.key, required this.recipe});

  final Recipe recipe;

  final String image = "https://picsum.photos/400/280";

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
              TopImage(imagePath: widget.image),
              SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(Routes.mainShell);
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
                widget.recipe.title,
                builder: (scrollController) => [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(19),
                        ),
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
                          TabItem(title: 'Tab 1'),
                          TabItem(title: 'Tab 2'),
                          TabItem(title: 'Tab 3'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _TableTab(
                          scrollController: scrollController,
                          headers: ['Ingredientes', 'Quantidade', 'Opções'],
                          rows: [
                            ['Leite', '240g', 2],
                            ['Fermento', '240g', 2],
                            ['Ovo', '1 unid', 2],
                            ['Manteiga', '70g', 2],
                          ],
                        ),
                        _TableTab(
                          scrollController: scrollController,
                          headers: ['Item', 'Valor unitário', 'Opções'],
                          rows: [
                            ['Gás', 'R\$0,92', 1],
                            ['Mão de obra', 'R\$0,00', 1],
                            ['Embalagem', 'R\$0,00', 1],
                            ['Entrega', 'R\$0,00', 1],
                          ],
                        ),
                        _TableTab(
                          scrollController: scrollController,
                          headers: ['Item', 'Valor unitário', 'Opções'],
                          rows: [
                            ['Gás', 'R\$0,92', 1],
                            ['Mão de obra', 'R\$0,00', 1],
                            ['Embalagem', 'R\$0,00', 1],
                            ['Entrega', 'R\$0,00', 1],
                          ],
                        ),
                      ],
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

class _TableTab extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> headers;
  final List<List<dynamic>> rows;

  const _TableTab({
    required this.scrollController,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        _TableHeader(headers: headers),
        const SizedBox(height: 8),
        ...rows.map(
          (row) => _TableRow(
            name: row[0] as String,
            value: row[1] as String,
            iconCount: row[2] as int,
          ),
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final List<String> headers;

  const _TableHeader({required this.headers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              headers[0],
              style: AppTexts.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              headers[1],
              style: AppTexts.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              headers[2],
              textAlign: TextAlign.end,
              style: AppTexts.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String name;
  final String value;
  final int iconCount;

  const _TableRow({
    required this.name,
    required this.value,
    required this.iconCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: AppTexts.bodyMedium.copyWith(color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTexts.bodyMedium.copyWith(color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                iconCount,
                (index) => Padding(
                  padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.brandAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
