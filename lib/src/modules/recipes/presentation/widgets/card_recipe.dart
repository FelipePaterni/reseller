import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

class CardRecipe extends StatelessWidget {
  final Recipe recipe;
  final String? imagePath;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Function? onTap;

  /// Constructor para uso com imagem (URL ou asset)
  const CardRecipe.image({
    super.key,
    required this.imagePath,
    required this.recipe,
    this.onTap,
  }) : icon = null,
       iconColor = null,
       iconBackgroundColor = null;

  /// Constructor para uso com ícone
  const CardRecipe.icon({
    super.key,
    required this.icon,
    required this.recipe,
    this.onTap,
    this.iconColor,
    this.iconBackgroundColor,
  }) : imagePath = null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap?.call(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildLeadingWidget(context),
              Text(
                recipe.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingWidget(BuildContext context) {
    // Se tem ícone, renderiza o ícone
    if (icon != null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBackgroundColor ?? AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 28, color: iconColor ?? AppColors.brandAccent),
      );
    }

    // Se tem imagem, renderiza a imagem com suporte a URL ou asset
    if (imagePath != null && imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(width: 48, height: 48, child: _buildImage(imagePath!)),
      );
    }

    // Fallback: ícone placeholder
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.image_outlined,
        size: 28,
        color: AppColors.disabled,
      ),
    );
  }

  Widget _buildImage(String path) {
    // Verifica se é URL (http ou https)
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: AppColors.surfaceVariant,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.brandAccent,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.surfaceVariant,
            child: const Icon(
              Icons.broken_image,
              size: 28,
              color: AppColors.disabled,
            ),
          );
        },
      );
    }

    // Caso contrário, trata como asset local
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: AppColors.surfaceVariant,
          child: const Icon(
            Icons.broken_image,
            size: 28,
            color: AppColors.disabled,
          ),
        );
      },
    );
  }
}
