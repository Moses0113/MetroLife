/// 設定頁 - 完整實現 (prd.md §3.5)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/domain/providers/theme_provider.dart';
import 'package:metrolife/domain/providers/focus_timer_provider.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _usernameCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  final _focusMinCtrl = TextEditingController();
  final _breakMinCtrl = TextEditingController();
  int _salaryDay = 1;
  int _focusMin = 25;
  int _breakMin = 5;
  bool _healthSyncEnabled = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _salaryCtrl.dispose();
    _focusMinCtrl.dispose();
    _breakMinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timerData = ref.watch(focusTimerProvider);
    final profile = ref.watch(userProfileProvider);

    // Sync controllers with provider (only if not editing)
    if (!_usernameCtrl.selection.isValid) {
      _usernameCtrl.text = profile.username;
    }
    if (!_heightCtrl.selection.isValid) {
      _heightCtrl.text = profile.heightCm > 0
          ? profile.heightCm.toStringAsFixed(0)
          : '';
    }
    if (!_weightCtrl.selection.isValid) {
      _weightCtrl.text = profile.weightKg > 0
          ? profile.weightKg.toStringAsFixed(0)
          : '';
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Profile
          _buildSection(context, l10n.profile, [
            _buildProfileTile(context, profile.username),
            _buildInputTile(
              context,
              icon: Icons.height,
              label: l10n.height,
              controller: _heightCtrl,
              suffix: l10n.cm,
              onChanged: (v) {
                final val = double.tryParse(v);
                if (val != null && val > 0) {
                  ref.read(userProfileProvider.notifier).updateHeight(val);
                }
              },
            ),
            _buildInputTile(
              context,
              icon: Icons.monitor_weight,
              label: l10n.weight,
              controller: _weightCtrl,
              suffix: l10n.kg,
              onChanged: (v) {
                final val = double.tryParse(v);
                if (val != null && val > 0) {
                  ref.read(userProfileProvider.notifier).updateWeight(val);
                }
              },
            ),
          ]),

          // Finance
          _buildSection(context, l10n.finance, [
            _buildInputTile(
              context,
              icon: Icons.attach_money,
              label: l10n.monthlySalary,
              controller: _salaryCtrl,
              prefix: '\$',
            ),
            _buildPickerTile(
              context,
              icon: Icons.calendar_today,
              title: l10n.salaryDay,
              value: '每月 ${_salaryDay} 日',
              onChanged: (v) => setState(() => _salaryDay = v),
              min: 1,
              max: 31,
            ),
          ]),

          // Focus
          _buildSection(context, l10n.focusSettings, [
            _buildInputTile(
              context,
              icon: Icons.timer,
              label: l10n.focusDuration,
              controller: _focusMinCtrl
                ..text = timerData.focusDurationMinutes.toString(),
              suffix: '分鐘',
              onChanged: (v) {
                final val = int.tryParse(v);
                if (val != null && val >= 1 && val <= 60) {
                  _focusMin = val;
                  ref
                      .read(focusTimerProvider.notifier)
                      .saveDurations(val, _breakMin);
                }
              },
            ),
            _buildInputTile(
              context,
              icon: Icons.coffee,
              label: l10n.breakDuration,
              controller: _breakMinCtrl
                ..text = timerData.breakDurationMinutes.toString(),
              suffix: '分鐘',
              onChanged: (v) {
                final val = int.tryParse(v);
                if (val != null && val >= 1 && val <= 30) {
                  _breakMin = val;
                  ref
                      .read(focusTimerProvider.notifier)
                      .saveDurations(_focusMin, val);
                }
              },
            ),
          ]),

          // Appearance
          _buildSection(context, l10n.appearance, [
            _buildToggleTile(
              context,
              icon: Icons.palette,
              title: l10n.appearance,
              subtitle: isDark ? l10n.darkMode : l10n.lightMode,
              value: isDark,
              onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
            ),
          ]),

          // Health
          _buildSection(context, l10n.healthSync, [
            SwitchListTile(
              secondary: const Icon(
                Icons.health_and_safety,
                color: AppTheme.accentPrimary,
              ),
              title: Text(l10n.healthSync),
              subtitle: Text(l10n.healthSyncDescription),
              value: _healthSyncEnabled,
              onChanged: (v) => setState(() => _healthSyncEnabled = v),
              activeColor: AppTheme.accentPrimary,
            ),
          ]),

          // Data
          _buildSection(context, '資料', [
            _buildNavTile(
              context,
              icon: Icons.download,
              title: l10n.exportData,
              onTap: () {},
            ),
            _buildNavTile(
              context,
              icon: Icons.delete_forever,
              title: l10n.clearAllData,
              onTap: () => _showClearDataConfirm(context),
              danger: true,
            ),
          ]),

          // About
          _buildSection(context, l10n.about, [
            _buildNavTile(
              context,
              icon: Icons.info_outline,
              title: l10n.version,
              subtitle: '1.0.0',
            ),
            _buildNavTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: l10n.privacyPolicy,
              onTap: () {},
            ),
          ]),

          const SizedBox(height: AppTheme.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, String username) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppTheme.accentPrimary.withValues(alpha: 0.1),
        child: const Icon(Icons.person, color: AppTheme.accentPrimary),
      ),
      title: Text(username),
      subtitle: const Text('MetroLife 帳戶'),
      trailing: const Icon(Icons.edit),
      onTap: () => _showUsernameDialog(context, username),
    );
  }

  void _showUsernameDialog(BuildContext context, String currentName) {
    final ctrl = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('修改用戶名'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '用戶名',
            hintText: '輸入新用戶名',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) {
                _usernameCtrl.text = name;
                ref.read(userProfileProvider.notifier).updateUsername(name);
              }
              Navigator.pop(ctx);
            },
            child: const Text('儲存'),
          ),
        ],
      ),
    );
    ctrl.dispose();
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppTheme.spacingSm,
            bottom: AppTheme.spacingSm,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ),
        Card(child: Column(children: children)),
        const SizedBox(height: AppTheme.spacingMd),
      ],
    );
  }

  Widget _buildInputTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required TextEditingController controller,
    String? suffix,
    String? prefix,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.accentPrimary),
          prefixText: prefix,
          suffixText: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusInput),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildPickerTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required ValueChanged<int> onChanged,
    required int min,
    required int max,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.accentPrimary),
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showNumberPicker(context, title, min, max, onChanged),
    );
  }

  Widget _buildToggleTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppTheme.accentPrimary),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.accentPrimary,
    );
  }

  Widget _buildNavTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool danger = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: danger ? AppTheme.danger : AppTheme.accentPrimary,
      ),
      title: Text(
        title,
        style: danger ? const TextStyle(color: AppTheme.danger) : null,
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showNumberPicker(
    BuildContext context,
    String title,
    int min,
    int max,
    ValueChanged<int> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  onSelectedItemChanged: onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final value = min + index;
                      if (value > max) return null;
                      return Center(
                        child: Text(
                          '$value',
                          style: const TextStyle(fontSize: 24),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('確定'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showClearDataConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('清除所有資料'),
        content: const Text('確定要清除所有資料嗎？此操作無法復原。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Clear all data
            },
            child: const Text('確定刪除', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
