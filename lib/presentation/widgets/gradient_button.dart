import 'package:flutter/material.dart';
import 'package:metrolife/core/theme/app_theme.dart';

/// 漸層按鈕 (UI.md §3.1 - 番茄鐘按鈕風格)
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.gradient,
    this.borderRadius,
    this.padding,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            gradient ??
            const LinearGradient(
              colors: [Color(0xFFFF6B6B), AppTheme.accentPrimary],
            ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppTheme.radiusButton,
        ),
        boxShadow: AppTheme.shadowGlow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppTheme.radiusButton,
          ),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg,
                  vertical: AppTheme.spacingMd,
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: AppTheme.spacingSm),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
