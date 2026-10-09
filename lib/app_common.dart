import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF1B0E09);
  static const card = Color(0xFF2B1810);
  static const accent = Color(0xFF7A4B2E);
  static const muted = Color(0xFFB89B86);
  static const highlight = Color(0xFFD9A066);
}

/// 
class NetImage extends StatelessWidget {
  final String url;
  final Alignment alignment;

  const NetImage(this.url, {super.key, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.card,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.muted,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) => Container(
        color: AppColors.card,
        child: const Icon(Icons.coffee, color: AppColors.muted, size: 48),
      ),
    );
  }
}