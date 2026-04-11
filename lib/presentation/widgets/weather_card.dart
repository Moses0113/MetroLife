/// 天氣卡片 Widget (UI.md §3.1)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/models/weather_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';
import 'package:metrolife/l10n/app_localizations.dart';

class WeatherCard extends ConsumerWidget {
  const WeatherCard({super.key, this.onForecastTap});

  final VoidCallback? onForecastTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    final warningsAsync = ref.watch(weatherWarningsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppTheme.bgSecondaryDark, AppTheme.bgTertiaryDark]
              : [
                  const Color(0xFF87CEEB).withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.9),
                ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          weatherAsync.when(
            loading: () => _buildLoading(context),
            error: (err, _) => _buildError(context, err),
            data: (weather) => _buildWeather(context, weather),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          warningsAsync.when(
            loading: () => const SizedBox(),
            error: (_, _) => const SizedBox(),
            data: (warnings) => _buildWarnings(context, warnings),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          GestureDetector(
            onTap: onForecastTap,
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context).view9DayForecast,
                  style: const TextStyle(
                    color: AppTheme.accentPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.accentPrimary,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(BuildContext context, Object err) {
    return Row(
      children: [
        const Icon(Icons.cloud_off, color: AppTheme.textSecondary, size: 32),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Text(
            AppLocalizations.of(context).unableToFetchData,
            style: const TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildWeather(BuildContext context, CurrentWeather weather) {
    return Row(
      children: [
        Icon(
          _getWeatherIcon(weather.desc),
          size: 48,
          color: AppTheme.accentPrimary,
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.thermostat,
                    size: 20,
                    color: AppTheme.accentPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${weather.temp}°C',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingLg),
                  const Icon(
                    Icons.water_drop,
                    size: 20,
                    color: AppTheme.accentPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${weather.humi}%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWarnings(BuildContext context, List<WeatherWarning> warnings) {
    if (warnings.isEmpty) return const SizedBox();

    final l10n = AppLocalizations.of(context);
    final warning = warnings.first;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSm,
        vertical: AppTheme.spacingXs + 2,
      ),
      decoration: BoxDecoration(
        color: AppTheme.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: AppTheme.warning, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              warning.name.isNotEmpty ? warning.name : l10n.rainWarning,
              style: const TextStyle(
                color: AppTheme.warning,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String desc) {
    final d = desc.toLowerCase();
    if (d.contains('雷') || d.contains('thunder')) {
      return Icons.flash_on;
    }
    if (d.contains('雨') || d.contains('rain')) {
      return Icons.water_drop;
    }
    if (d.contains('微') || d.contains('驟') || d.contains('driz')) {
      return Icons.grain;
    }
    if (d.contains('雲') || d.contains('cloud')) {
      return Icons.cloud;
    }
    if (d.contains('晴') || d.contains('sunny') || d.contains('fine')) {
      return Icons.wb_sunny;
    }
    return Icons.cloud;
  }
}
