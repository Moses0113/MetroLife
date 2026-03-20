/// 9天天氣預報底部面板 (prd.md §3.1)
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
        // General Situation
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
        // Daily forecast cards
        ...forecast.weatherForecast.map((day) => _buildDayCard(context, day)),
        // Sea & Soil temps
        ..._buildTempCards(context, forecast),
        const SizedBox(height: AppTheme.spacingLg),
      ],
    );
  }

  Widget _buildDayCard(BuildContext context, ForecastDay day) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Row(
          children: [
            // Date & Day
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
            // Weather icon
            Icon(
              _getWeatherIcon(day.forecastWeather),
              size: 28,
              color: AppTheme.accentPrimary,
            ),
            const SizedBox(width: AppTheme.spacingSm),
            // Temp
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${day.forecastMaxtemp}° / ${day.forecastMintemp}°',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    day.forecastWeather,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // PSR
            if (day.PSR.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _getPsrColor(day.PSR).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                ),
                child: Text(
                  day.PSR,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getPsrColor(day.PSR),
                  ),
                ),
              ),
          ],
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
    if (d.contains('sunny') || d.contains('fine')) return Icons.wb_sunny;
    if (d.contains('cloud')) return Icons.cloud;
    if (d.contains('rain') || d.contains('shower')) return Icons.grain;
    if (d.contains('thunder')) return Icons.flash_on;
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
