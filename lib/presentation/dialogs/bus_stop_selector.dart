/// 巴士站選擇器 Dialog
library;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/bus_stop_selection_provider.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';

class BusStopSelector extends ConsumerStatefulWidget {
  const BusStopSelector({super.key});

  @override
  ConsumerState<BusStopSelector> createState() => _BusStopSelectorState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const BusStopSelector(),
    );
  }
}

class _BusStopSelectorState extends ConsumerState<BusStopSelector> {
  final _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _allStops = [];
  List<Map<String, dynamic>> _filteredStops = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStops();
  }

  Future<void> _loadStops() async {
    final busService = ref.read(busServiceProvider);
    final stops = await busService.getAllStops();
    _allStops = stops
        .map(
          (s) => {
            'stop': s.stop,
            'nameTc': s.nameTc,
            'nameEn': s.nameEn,
            'lat': s.lat,
            'long': s.long,
          },
        )
        .toList();
    _filteredStops = [];
    setState(() => _loading = false);
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() => _filteredStops = []);
      return;
    }
    setState(() {
      _filteredStops = _allStops
          .where(
            (s) =>
                (s['nameTc'] as String).contains(query) ||
                (s['nameEn'] as String).toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                (s['stop'] as String).contains(query),
          )
          .take(20)
          .toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final insets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: DraggableScrollableSheet(
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
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textTertiary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(AppTheme.spacingMd),
                  child: Text(
                    '選擇巴士站',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                  ),
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: const InputDecoration(
                      hintText: '搜尋站名或站號...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _onSearch,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                // Content
                Expanded(
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd,
                          ),
                          children: [
                            // 3 nearest stops
                            _buildNearestSection(context),
                            const SizedBox(height: AppTheme.spacingMd),
                            // Search results or history
                            if (_searchCtrl.text.isNotEmpty)
                              _buildSearchResults(context)
                            else
                              _buildHistorySection(context),
                            const SizedBox(height: AppTheme.spacingLg),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearestSection(BuildContext context) {
    final nearestAsync = ref.watch(nearest3StopsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacingSm,
            bottom: AppTheme.spacingSm,
          ),
          child: Text(
            '📍 最近的站',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        nearestAsync.when(
          loading: () => const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(),
            ),
          ),
          error: (_, _) => const Card(
            child: Padding(padding: EdgeInsets.all(16), child: Text('無法取得位置')),
          ),
          data: (stops) => Column(
            children: stops.map((pair) {
              final stop = pair.$1;
              final dist = pair.$2;
              return _buildStopCard(
                context,
                stopId: stop.stop,
                nameTc: stop.nameTc,
                nameEn: stop.nameEn,
                lat: stop.lat,
                long: stop.long,
                distance: dist,
                icon: Icons.place,
                iconColor: AppTheme.accentPrimary,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    final history = ref.watch(busStopHistoryProvider);

    if (history.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '暫無搜尋記錄',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacingSm,
            bottom: AppTheme.spacingSm,
          ),
          child: Text(
            '🕐 搜尋記錄',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        ...history.map(
          (stop) => _buildStopCard(
            context,
            stopId: stop.stopId,
            nameTc: stop.nameTc,
            nameEn: stop.nameEn,
            lat: stop.lat,
            long: stop.long,
            distance: stop.distanceMeters,
            icon: Icons.history,
            iconColor: AppTheme.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    if (_filteredStops.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('找不到結果', style: TextStyle(color: AppTheme.textSecondary)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppTheme.spacingSm,
            bottom: AppTheme.spacingSm,
          ),
          child: Text(
            '搜尋結果 (${_filteredStops.length})',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        ..._filteredStops.map(
          (stop) => _buildStopCard(
            context,
            stopId: stop['stop'] as String,
            nameTc: stop['nameTc'] as String,
            nameEn: stop['nameEn'] as String,
            lat: stop['lat'] as double,
            long: stop['long'] as double,
            distance: 0,
            icon: Icons.directions_bus,
            iconColor: AppTheme.accentPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStopCard(
    BuildContext context, {
    required String stopId,
    required String nameTc,
    required String nameEn,
    required double lat,
    required double long,
    required double distance,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          nameTc,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(nameEn, style: const TextStyle(fontSize: 12)),
        trailing: distance > 0
            ? Text(
                '${distance.toStringAsFixed(0)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              )
            : null,
        onTap: () {
          ref
              .read(selectedBusStopProvider.notifier)
              .select(
                SelectedBusStop(
                  stopId: stopId,
                  nameTc: nameTc,
                  nameEn: nameEn,
                  lat: lat,
                  long: long,
                  distanceMeters: distance,
                ),
              );
          // Refresh ETA
          ref.invalidate(busEtaProvider(stopId));
          Navigator.pop(context);
        },
      ),
    );
  }
}
