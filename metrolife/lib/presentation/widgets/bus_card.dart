/// 巴士卡片 Widget (UI.md §3.1)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/models/bus_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';
import 'package:metrolife/l10n/app_localizations.dart';

class BusCard extends ConsumerWidget {
  const BusCard({super.key, this.onRefresh});

  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearestAsync = ref.watch(nearestBusStopProvider);
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.directions_bus,
                  color: AppTheme.accentPrimary,
                  size: 20,
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Text(
                  l10n.nearestStop,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: () {
                    ref.invalidate(nearestBusStopProvider);
                    onRefresh?.call();
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const Divider(),
            nearestAsync.when(
              loading: () => const SizedBox(
                height: 60,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => Text(
                l10n.unableToFetchData,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
              data: (result) => _buildBusInfo(context, ref, result),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusInfo(
    BuildContext context,
    WidgetRef ref,
    (BusStop, double) result,
  ) {
    final (stop, distance) = result;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stop.nameTc.isNotEmpty ? stop.nameTc : stop.nameEn,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        if (stop.nameEn.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            stop.nameEn,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
        const SizedBox(height: 4),
        Text(
          '📍 ${distance.toStringAsFixed(0)} ${l10n.distanceAway}',
          style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        _buildEtaList(context, ref, stop.stop),
      ],
    );
  }

  Widget _buildEtaList(BuildContext context, WidgetRef ref, String stopId) {
    final etaAsync = ref.watch(busEtaProvider(stopId));

    return etaAsync.when(
      loading: () => const SizedBox(
        height: 40,
        child: Center(child: LinearProgressIndicator()),
      ),
      error: (_, __) => const SizedBox(),
      data: (etas) {
        if (etas.isEmpty) {
          return const Text(
            '暫無到站時間',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
          );
        }

        // Group by route
        final routeMap = <String, List<BusEta>>{};
        for (final eta in etas) {
          routeMap.putIfAbsent(eta.route, () => []).add(eta);
        }

        return Column(
          children: routeMap.entries.take(5).map((entry) {
            final route = entry.key;
            final routeEtas = entry.value;
            final nextEta = routeEtas.first;
            final etaTime = _parseEta(nextEta.eta);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      route,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Text(etaTime, style: const TextStyle(fontSize: 14)),
                  if (nextEta.rmkTc.isNotEmpty) ...[
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      nextEta.rmkTc,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _parseEta(String etaStr) {
    if (etaStr.isEmpty) return '—';
    try {
      final eta = DateTime.parse(etaStr);
      final now = DateTime.now();
      final diff = eta.difference(now);
      if (diff.inMinutes <= 0) return '即將到站';
      if (diff.inMinutes < 60) return '${diff.inMinutes} 分鐘';
      return '${diff.inMinutes ~/ 60}h ${diff.inMinutes % 60}m';
    } catch (_) {
      return '—';
    }
  }
}
