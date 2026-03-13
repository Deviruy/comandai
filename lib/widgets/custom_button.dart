import 'package:flutter/material.dart';

/// Botão padronizado de acordo com o design do Stitch.
/// Adapta-se automaticamente ao tema ativo (Pizzaria, Doces, Açaí).
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.transparent : colorScheme.primary,
        foregroundColor: isSecondary ? colorScheme.primary : Colors.white,
        elevation: isSecondary ? 0 : 2,
        side: isSecondary ? BorderSide(color: colorScheme.primary) : null,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
