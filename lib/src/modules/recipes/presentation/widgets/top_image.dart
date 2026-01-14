import 'package:flutter/material.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/dynamic_image.dart';

class TopImage extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  /// Constructor para uso com ícone
  const TopImage({
    super.key,
    this.icon,
    this.imagePath,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: DynamicImage(
        source: imagePath,
        icon: icon,
        iconColor: iconColor,
        backgroundColor: iconBackgroundColor,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
