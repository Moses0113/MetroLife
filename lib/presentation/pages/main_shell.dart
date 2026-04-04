import 'package:flutter/material.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/l10n/app_localizations.dart';

import 'home_page.dart';
import 'daily_page.dart';
import 'finance_page.dart';
import 'exercise_page.dart';
import 'settings_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 2;

  void _navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  late final List<Widget> _pages = [
    const DailyPage(),
    const FinancePage(),
    HomePage(onNavigateToSettings: _navigateToTab),
    const ExercisePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor.withValues(alpha: 0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusLarge),
            topRight: Radius.circular(AppTheme.radiusLarge),
          ),
          boxShadow: AppTheme.shadowLg,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSm,
              vertical: AppTheme.spacingSm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.calendar_today, l10n.daily),
                _buildNavItem(1, Icons.account_balance_wallet, l10n.finance),
                _buildHomeButton(2),
                _buildNavItem(3, Icons.directions_run, l10n.exercise),
                _buildNavItem(4, Icons.settings, l10n.settings),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm,
          vertical: AppTheme.spacingXs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          color: isSelected
              ? AppTheme.accentPrimary.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isSelected ? 26 : 22,
              color: isSelected
                  ? AppTheme.accentPrimary
                  : Theme.of(context).textTheme.bodySmall?.color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? AppTheme.accentPrimary
                    : Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppTheme.accentPrimary,
          shape: BoxShape.circle,
          boxShadow: isSelected ? AppTheme.shadowGlow : null,
        ),
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: isSelected ? 28 : 24,
        ),
      ),
    );
  }
}
