/// 巴士卡片 Widget (UI.md §3.1)
library;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/models/bus_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';
import 'package:metrolife/domain/providers/bus_stop_selection_provider.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/presentation/dialogs/bus_stop_selector.dart';
import 'package:metrolife/presentation/dialogs/bus_route_selector.dart';

class BusCard extends ConsumerStatefulWidget {
  const BusCard({super.key});

  @override
  ConsumerState<BusCard> createState() => _BusCardState();
}

class _BusCardState extends ConsumerState<BusCard> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _refreshBusData(),
    );
  }

  void _refreshBusData() {
    final selectedStop = ref.read(selectedBusStopProvider);
    if (selectedStop != null) {
      ref.invalidate(busEtaProvider(selectedStop.stopId));
    } else {
      ref.invalidate(nearestBusStopProvider);
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedStop = ref.watch(selectedBusStopProvider);

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
                Expanded(
                  child: Text(
                    selectedStop != null
                        ? selectedStop.nameTc
                        : l10n.nearestStop,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 20),
                  onPressed: () => BusStopSelector.show(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const Divider(),
            if (selectedStop != null)
              _buildStopInfo(context, ref, selectedStop)
            else
              _buildNearestAuto(context, ref, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildNearestAuto(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final nearestAsync = ref.watch(nearestBusStopProvider);

    return nearestAsync.when(
      loading: () => const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Column(
        children: [
          Text(
            l10n.unableToFetchData,
            style: const TextStyle(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => BusStopSelector.show(context),
            child: const Text('手動選擇站點'),
          ),
        ],
      ),
      data: (result) {
        final (stop, distance) = result;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (stop.nameEn.isNotEmpty)
              Text(
                stop.nameEn,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            const SizedBox(height: 4),
            Text(
              '📍 ${distance.toStringAsFixed(0)} ${l10n.distanceAway}',
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildEtaList(context, ref, stop.stop),
            const SizedBox(height: AppTheme.spacingSm),
            _buildActions(context),
          ],
        );
      },
    );
  }

  Widget _buildStopInfo(
    BuildContext context,
    WidgetRef ref,
    SelectedBusStop stop,
  ) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stop.nameEn.isNotEmpty)
          Text(
            stop.nameEn,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        const SizedBox(height: 4),
        if (stop.distanceMeters > 0)
          Text(
            '📍 ${stop.distanceMeters.toStringAsFixed(0)} ${l10n.distanceAway}',
            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
        const SizedBox(height: AppTheme.spacingSm),
        _buildEtaList(context, ref, stop.stopId),
        const SizedBox(height: AppTheme.spacingSm),
        _buildActions(context),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () => BusStopSelector.show(context),
          icon: const Icon(Icons.search, size: 16),
          label: const Text('選站'),
        ),
        const SizedBox(width: AppTheme.spacingSm),
        TextButton.icon(
          onPressed: () => BusRouteSelector.show(context),
          icon: const Icon(Icons.route, size: 16),
          label: const Text('選綫'),
        ),
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
      error: (_, _) => const SizedBox(),
      data: (etas) {
        if (etas.isEmpty) {
          return const Text(
            '暫無到站時間',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
          );
        }

        final routeMap = <String, List<BusEta>>{};
        for (final eta in etas) {
          routeMap.putIfAbsent(eta.route, () => []).add(eta);
        }

        return Column(
          children: routeMap.entries.take(6).map((entry) {
            final route = entry.key;
            final routeEtas = entry.value;
            final nextEta = routeEtas.first;
            final etaTime = _parseEta(nextEta.eta);
            final dest = nextEta.destTc.isNotEmpty ? nextEta.destTc : '';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () => BusRouteSelector.show(context),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accentPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        route,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (dest.isNotEmpty)
                            Text(
                              '→ $dest',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          if (nextEta.rmkTc.isNotEmpty)
                            Text(
                              nextEta.rmkTc,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      etaTime,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.accentPrimary,
                      ),
                    ),
                  ],
                ),
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
      final diff = eta.difference(DateTime.now());
      if (diff.inMinutes <= 0) return '即將到站';
      if (diff.inMinutes < 60) return '${diff.inMinutes} 分鐘';
      return '${diff.inMinutes ~/ 60}h ${diff.inMinutes % 60}m';
    } catch (_) {
      return '—';
    }
  }
}
