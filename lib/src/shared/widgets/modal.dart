import 'package:flutter/material.dart';

///``` 
///Usage:
/// ElevatedButton.icon(
///            onPressed: () {
///           showDialog(
///              context: context,
///               builder: (_) => Modal(
///                 title: 'Confirmar',
///                 child: const Text('Você tem certeza?'),
///                 onConfirm: () =>
///                   Navigator.of(context).pushNamed(Routes.recipesInfo),
///                ),
///              );
///            },
///            label: const Text("A"),
///            icon: const Icon(Icons.headphones),
///           ),
///  ```
class Modal extends StatelessWidget {
  final String title;
  final Widget child;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;

  const Modal({
    super.key,
    required this.title,
    required this.child,
    this.confirmText = 'Sim',
    this.cancelText = 'Não',
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: child,
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText ?? 'Não'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm?.call();
          },
          child: Text(confirmText ?? 'Sim'),
        ),
      ],
    );
  }
}
