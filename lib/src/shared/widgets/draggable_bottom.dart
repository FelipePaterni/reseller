import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/core/theme/app_texts.dart';

class DraggableBottom extends StatelessWidget {
  const DraggableBottom(this.title, {super.key, required this.builder});

  final List<Widget> Function(ScrollController controller) builder;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.575,
      minChildSize: 0.55,
      maxChildSize: 0.89,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: title.isNotEmpty
                    ? Text(title, style: AppTexts.titleLarge)
                    : null,
              ),
              Expanded(child: Column(children: builder(scrollController))),
            ],
          ),
        );
      },
    );
  }
}
