import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_colors.dart';

/// Enum para definir o tipo de conteúdo
enum ContentType { image, icon, auto }

class DynamicImage extends StatelessWidget {
  final String? source;
  final IconData? icon;
  final ContentType type;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? iconSize;
  final BoxFit? imageFit;
  final BorderRadius? borderRadius;

  /// Constructor padrão com detecção automática de tipo
  const DynamicImage({
    super.key,
    this.source,
    this.icon,
    this.type = ContentType.auto,
    this.iconColor,
    this.backgroundColor,
    this.height,
    this.width,
    this.iconSize = 120,
    this.imageFit = BoxFit.cover,
    this.borderRadius,
  });

  /// Constructor para uso com imagem URL ou asset
  const DynamicImage.image({
    super.key,
    required this.source,
    this.height,
    this.width,
    this.imageFit = BoxFit.cover,
    this.backgroundColor,
    this.borderRadius,
  }) : type = ContentType.image,
       icon = null,
       iconColor = null,
       iconSize = 120;

  /// Constructor para uso com ícone
  const DynamicImage.icon({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.iconSize = 120,
    this.height,
    this.width,
    this.borderRadius,
  }) : source = null,
       type = ContentType.icon,
       imageFit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceVariant,
        borderRadius: borderRadius,
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // Determina o tipo de conteúdo
    final contentType = _resolveContentType();

    return switch (contentType) {
      ContentType.icon => _buildIconContent(),
      ContentType.image => _buildImageContent(),
      ContentType.auto => _buildAutoContent(),
    };
  }

  Widget _buildIconContent() {
    return Center(
      child: Icon(
        icon ?? Icons.image_outlined,
        size: iconSize,
        color: iconColor ?? AppColors.brandAccent,
      ),
    );
  }

  Widget _buildImageContent() {
    if (source == null || source!.isEmpty) {
      return _buildPlaceholder();
    }
    return _buildImage(source!);
  }

  Widget _buildAutoContent() {
    // Se houver ícone explícito, renderiza ícone
    if (icon != null) {
      return _buildIconContent();
    }

    // Se houver source, renderiza como imagem
    if (source != null && source!.isNotEmpty) {
      return _buildImageContent();
    }

    // Fallback: placeholder
    return _buildPlaceholder();
  }

  Widget _buildImage(String path) {
    final imageType = _detectImageType(path);

    return switch (imageType) {
      _ImageType.network => _buildNetworkImage(path),
      _ImageType.file => _buildFileImage(path),
      _ImageType.asset => _buildAssetImage(path),
    };
  }

  Widget _buildNetworkImage(String url) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        url,
        fit: imageFit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: AppColors.brandAccent,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildFileImage(String path) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.file(
        File(path),
        fit: imageFit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildAssetImage(String path) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        path,
        fit: imageFit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Icon(
        Icons.broken_image_outlined,
        size: iconSize ?? 48,
        color: AppColors.disabled,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        size: iconSize ?? 48,
        color: AppColors.disabled,
      ),
    );
  }

  /// Detecta automaticamente o tipo de imagem baseado na entrada
  _ImageType _detectImageType(String path) {
    // URL: HTTP ou HTTPS
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return _ImageType.network;
    }

    // Arquivo local: caminho absoluto com separadores do SO
    if (path.startsWith('/') || path.startsWith('\\') || path.contains(':')) {
      return _ImageType.file;
    }

    // Asset: sem separadores ou com 'assets/' prefix
    return _ImageType.asset;
  }

  /// Resolve o tipo de conteúdo final
  ContentType _resolveContentType() {
    if (type != ContentType.auto) {
      return type;
    }

    if (icon != null) return ContentType.icon;
    if (source != null && source!.isNotEmpty) return ContentType.image;

    return ContentType.image; // fallback padrão
  }
}

enum _ImageType { network, file, asset }
