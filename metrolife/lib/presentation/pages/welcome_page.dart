/// 首次啟動歡迎頁
/// 參考: prd.md Section 6.3

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/core/utils/rabbit_svg.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              const RabbitSvgWidget(type: 'idle', size: 160),
              const SizedBox(height: AppTheme.spacingXl),

              const Text(
                'MetroLife',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              const Text(
                '香港生活管家',
                style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: AppTheme.spacingXl),

              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.shadowSm,
                ),
                child: const Text(
                  '你好！我係勤力兔，一齊打理生活啦！',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXl),

              TextField(
                controller: _nameCtrl,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: '輸入你的名稱',
                  hintStyle: TextStyle(fontSize: 16),
                ),
                autofocus: true,
              ),
              const SizedBox(height: AppTheme.spacingXl),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onStart,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '開始使用',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onStart() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    await ref.read(userProfileProvider.notifier).updateUsername(name);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_welcome', true);

    widget.onComplete();
  }
}
