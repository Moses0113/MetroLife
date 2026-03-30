import 'package:flutter/material.dart';
import 'package:metrolife/core/theme/app_theme.dart';

/// 通用卡片組件 (UI.md §2.3)
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.bgSecondaryDark : AppTheme.bgSecondary;
    final r = borderRadius ?? AppTheme.radiusMedium;

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(r),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: gradient == null ? bgColor : null,
              gradient: gradient,
              borderRadius: BorderRadius.circular(r),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
              ),
              boxShadow: AppTheme.shadowSm,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
