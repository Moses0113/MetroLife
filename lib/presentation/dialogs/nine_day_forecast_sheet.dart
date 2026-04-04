/// 9天天氣預報底部面板 (prd.md §3.1)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/models/weather_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';
import 'package:metrolife/l10n/app_localizations.dart';

class NineDayForecastSheet extends ConsumerWidget {
  const NineDayForecastSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NineDayForecastSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(nineDayForecastProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.bgPrimaryDark : AppTheme.bgPrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLarge),
              topRight: Radius.circular(AppTheme.radiusLarge),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Row(
                  children: [
                    const Icon(Icons.cloud, color: AppTheme.accentPrimary),
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      l10n.view9DayForecast,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: forecastAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) =>
                      Center(child: Text(l10n.unableToFetchData)),
                  data: (forecast) =>
                      _buildForecastList(context, forecast, scrollController),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForecastList(
    BuildContext context,
    NineDayForecast forecast,
    ScrollController controller,
  ) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
      children: [
        if (forecast.generalSituation.isNotEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).generalSituation,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    forecast.generalSituation,
                    style: const TextStyle(fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppTheme.spacingSm),
        ...forecast.weatherForecast.map((day) => _buildDayCard(context, day)),
        ..._buildTempCards(context, forecast),
        const SizedBox(height: AppTheme.spacingLg),
      ],
    );
  }

  Widget _buildDayCard(BuildContext context, ForecastDay day) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => DayForecastDialog.show(context, day),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppTheme.bgSecondaryDark : AppTheme.bgSecondary,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(
                color: AppTheme.textTertiary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Text(
                        _formatDate(day.forecastDate),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        day.week,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Icon(
                  _getWeatherIcon(day.forecastWeather),
                  size: 24,
                  color: AppTheme.accentPrimary,
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: Text(
                    '${day.forecastMaxtemp}° / ${day.forecastMintemp}°',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTempCards(BuildContext context, NineDayForecast forecast) {
    final widgets = <Widget>[];
    for (final temp in [...forecast.seaTemp, ...forecast.soilTemp]) {
      widgets.add(
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.thermostat,
              color: AppTheme.accentPrimary,
            ),
            title: Text(temp.place),
            trailing: Text(
              '${temp.value}°${temp.unit}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  String _formatDate(String dateStr) {
    if (dateStr.length == 8) {
      return '${dateStr.substring(6, 8)}/${dateStr.substring(4, 6)}';
    }
    return dateStr;
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

  Color _getPsrColor(String psr) {
    switch (psr.toLowerCase()) {
      case 'high':
        return AppTheme.danger;
      case 'medium':
        return AppTheme.warning;
      case 'low':
        return AppTheme.success;
      default:
        return AppTheme.textSecondary;
    }
  }
}

class DayForecastDialog extends StatelessWidget {
  final ForecastDay day;

  const DayForecastDialog({super.key, required this.day});

  static void show(BuildContext context, ForecastDay day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DayForecastDialog(day: day),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.bgPrimaryDark : AppTheme.bgPrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLarge),
              topRight: Radius.circular(AppTheme.radiusLarge),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Row(
                  children: [
                    Icon(
                      _getWeatherIcon(day.forecastWeather),
                      color: AppTheme.accentPrimary,
                      size: 24,
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      '${_formatDate(day.forecastDate)} ${day.week}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppTheme.spacingLg),
                      decoration: BoxDecoration(
                        color: AppTheme.accentPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _getWeatherIcon(day.forecastWeather),
                            size: 48,
                            color: AppTheme.accentPrimary,
                          ),
                          const SizedBox(height: AppTheme.spacingSm),
                          Text(
                            day.forecastWeather,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    _buildDetailRow(
                      context,
                      l10n.forecastDate,
                      '${_formatDate(day.forecastDate)} (${day.week})',
                    ),
                    _buildDetailRow(
                      context,
                      '溫度',
                      '${day.forecastMintemp}° - ${day.forecastMaxtemp}°',
                    ),
                    _buildDetailRow(
                      context,
                      '相對濕度',
                      '${day.forecastMinrh}% - ${day.forecastMaxrh}%',
                    ),
                    _buildDetailRow(
                      context,
                      '風向',
                      day.forecastWind.isNotEmpty ? day.forecastWind : '-',
                    ),
                    if (day.PSR.isNotEmpty)
                      _buildDetailRow(
                        context,
                        '紫外線',
                        day.PSR,
                        valueColor: _getPsrColor(day.PSR),
                      ),
                    const SizedBox(height: AppTheme.spacingLg),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.spacingSm,
        horizontal: AppTheme.spacingMd,
      ),
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.bgSecondaryDark : AppTheme.bgSecondary,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    if (dateStr.length == 8) {
      return '${dateStr.substring(6, 8)}/${dateStr.substring(4, 6)}';
    }
    return dateStr;
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

  Color _getPsrColor(String psr) {
    switch (psr.toLowerCase()) {
      case 'high':
        return AppTheme.danger;
      case 'medium':
        return AppTheme.warning;
      case 'low':
        return AppTheme.success;
      default:
        return AppTheme.textSecondary;
    }
  }
}
