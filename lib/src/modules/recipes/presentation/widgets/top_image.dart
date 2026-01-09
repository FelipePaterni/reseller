import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';

class TopImage extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  /// Constructor para uso com imagem (URL ou asset)
  const TopImage.image({super.key, required this.imagePath})
    : icon = null,
      iconColor = null,
      iconBackgroundColor = null;

  /// Constructor para uso com ícone
  const TopImage.icon({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconBackgroundColor,
  }) : imagePath = null;

  /// Constructor padrão (mantém compatibilidade)
  const TopImage({super.key, required String this.imagePath})
    : icon = null,
      iconColor = null,
      iconBackgroundColor = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Se tem ícone, renderiza o ícone
    if (icon != null) {
      return Container(
        color: iconBackgroundColor ?? AppColors.surfaceVariant,
        child: Center(
          child: Icon(
            icon,
            size: 120,
            color: iconColor ?? AppColors.brandAccent,
          ),
        ),
      );
    }

    // Se tem imagem, renderiza a imagem com suporte a URL ou asset
    if (imagePath != null && imagePath!.isNotEmpty) {
      return _buildImage(imagePath!);
    }

    // Fallback: ícone placeholder
    return Container(
      color: AppColors.surfaceVariant,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 120, color: AppColors.disabled),
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
              child: CircularProgressIndicator(color: AppColors.brandAccent),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.surfaceVariant,
            child: const Center(
              child: Icon(
                Icons.broken_image,
                size: 120,
                color: AppColors.disabled,
              ),
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
          child: const Center(
            child: Icon(
              Icons.broken_image,
              size: 120,
              color: AppColors.disabled,
            ),
          ),
        );
      },
    );
  }
}
