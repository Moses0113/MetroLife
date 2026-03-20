/// 巴士綫選擇器 — 直接輸入綫號，無需先選站
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/models/bus_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';
import 'package:metrolife/domain/providers/bus_stop_selection_provider.dart';
import 'package:metrolife/data/repositories/kmb_bus_service.dart';

class BusRouteSelector extends ConsumerStatefulWidget {
  const BusRouteSelector({super.key});

  @override
  ConsumerState<BusRouteSelector> createState() => _BusRouteSelectorState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const BusRouteSelector(),
    );
  }
}

class _BusRouteSelectorState extends ConsumerState<BusRouteSelector> {
  final _routeCtrl = TextEditingController();
  List<Map<String, dynamic>> _allRoutes = [];
  List<Map<String, dynamic>> _matchedRoutes = [];
  List<BusStop> _routeStops = [];
  String? _selectedRouteKey;
  bool _loadingRoutes = true;
  bool _loadingStops = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAllRoutes());
  }

  Future<void> _loadAllRoutes() async {
    try {
      final busService = ref.read(busServiceProvider);
      final routes = await busService.getAllRoutes();
      if (mounted) {
        setState(() {
          _allRoutes = routes;
          _loadingRoutes = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingRoutes = false);
      }
    }
  }

  void _searchRoute(String query) {
    _selectedRouteKey = null;
    _routeStops = [];
    if (query.isEmpty) {
      setState(() => _matchedRoutes = []);
      return;
    }
    final q = query.toUpperCase().trim();
    setState(() {
      _matchedRoutes =
          _allRoutes
              .where((r) => (r['route'] as String).toUpperCase().startsWith(q))
              .toList()
            ..sort(
              (a, b) => (a['route'] as String).compareTo(b['route'] as String),
            );
    });
  }

  Future<void> _onRouteSelected(Map<String, dynamic> route) async {
    final routeNum = route['route'] as String;
    final bound = route['bound'] as String;
    final serviceType = route['service_type'] as int;
    final key = '${routeNum}_${bound}_$serviceType';

    setState(() {
      _selectedRouteKey = key;
      _loadingStops = true;
      _routeStops = [];
    });

    try {
      final busService = ref.read(busServiceProvider);
      final stops = await busService.getRouteStops(
        routeNum,
        bound,
        serviceType,
      );
      if (mounted) {
        setState(() {
          _routeStops = stops;
          _loadingStops = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingStops = false);
      }
    }
  }

  @override
  void dispose() {
    _routeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.bgPrimaryDark : AppTheme.bgPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusLarge),
            topRight: Radius.circular(AppTheme.radiusLarge),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textTertiary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                children: [
                  const Icon(Icons.route, color: AppTheme.accentPrimary),
                  const SizedBox(width: AppTheme.spacingSm),
                  Text(
                    _selectedRouteKey != null
                        ? '路綫 ${_selectedRouteKey?.split("_")[0]} — 選擇站點'
                        : '選擇巴士綫',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (_selectedRouteKey != null)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => setState(() {
                        _selectedRouteKey = null;
                        _routeStops = [];
                      }),
                    ),
                ],
              ),
            ),
            // Search bar (only when not showing stops)
            if (_selectedRouteKey == null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                ),
                child: TextField(
                  controller: _routeCtrl,
                  decoration: InputDecoration(
                    hintText: '輸入綫號 (如 1A, 960)...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _routeCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _routeCtrl.clear();
                              _searchRoute('');
                            },
                          )
                        : null,
                  ),
                  autofocus: true,
                  onChanged: _searchRoute,
                ),
              ),
            if (_selectedRouteKey == null)
              const SizedBox(height: AppTheme.spacingSm),
            // Content
            Expanded(
              child: _selectedRouteKey != null
                  ? _buildStopsList()
                  : _buildRouteResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteResults() {
    if (_loadingRoutes) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_allRoutes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '無法載入路綫資料\n請檢查網絡連接',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      );
    }

    if (_routeCtrl.text.isEmpty) {
      // Show popular routes when no search
      final popular =
          _allRoutes
              .where(
                (r) => [
                  '1',
                  '2',
                  '6',
                  '9',
                  '11',
                  '14',
                  '70',
                  '101',
                  '102',
                  '104',
                  '111',
                  '112',
                  '113',
                  '116',
                  '118',
                  '601',
                  '603',
                  '619',
                  '671',
                  '680',
                  '681',
                  '690',
                  '960',
                  '961',
                  '968',
                ].contains(r['route']),
              )
              .toList()
            ..sort(
              (a, b) => (a['route'] as String).compareTo(b['route'] as String),
            );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: AppTheme.spacingMd,
              bottom: AppTheme.spacingSm,
            ),
            child: Text(
              '熱門路綫',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
              ),
              itemCount: popular.length,
              itemBuilder: (context, index) => _buildRouteCard(popular[index]),
            ),
          ),
        ],
      );
    }

    if (_matchedRoutes.isEmpty) {
      return Center(
        child: Text(
          '找不到「${_routeCtrl.text}」',
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
      itemCount: _matchedRoutes.length,
      itemBuilder: (context, index) => _buildRouteCard(_matchedRoutes[index]),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    final routeNum = route['route'] as String;
    final bound = route['bound'] as String;
    final serviceType = route['service_type'] as int;
    final origTc = route['orig_tc'] as String;
    final destTc = route['dest_tc'] as String;
    final key = '${routeNum}_${bound}_$serviceType';
    final selected = _selectedRouteKey == key;
    final isSpecial = serviceType > 1;

    return Card(
      color: selected ? AppTheme.accentPrimary.withValues(alpha: 0.1) : null,
      child: ListTile(
        leading: Container(
          width: 52,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.accentPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              routeNum,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                '$origTc → $destTc',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSpecial)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '特別',
                  style: TextStyle(fontSize: 10, color: AppTheme.warning),
                ),
              ),
          ],
        ),
        subtitle: Text(
          bound == 'O' ? '去程 (Outbound)' : '回程 (Inbound)',
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onRouteSelected(route),
      ),
    );
  }

  Widget _buildStopsList() {
    if (_loadingStops) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_routeStops.isEmpty) {
      return const Center(child: Text('此路綫暫無站點資料'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      itemCount: _routeStops.length,
      itemBuilder: (context, index) {
        final stop = _routeStops[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.accentPrimary,
              radius: 16,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(stop.nameTc, style: const TextStyle(fontSize: 14)),
            subtitle: stop.nameEn.isNotEmpty
                ? Text(
                    stop.nameEn,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  )
                : null,
            onTap: () {
              ref
                  .read(selectedBusStopProvider.notifier)
                  .select(
                    SelectedBusStop(
                      stopId: stop.stop,
                      nameTc: stop.nameTc,
                      nameEn: stop.nameEn,
                      lat: stop.lat,
                      long: stop.long,
                    ),
                  );
              ref.invalidate(busEtaProvider(stop.stop));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
