/// 番茄鐘全屏頁面
/// 參考: prd.md §3.5, UI.md §4.1

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/focus_timer_provider.dart';
import 'package:metrolife/presentation/widgets/diligent_rabbit_overlay.dart';

class FocusTimerPage extends ConsumerWidget {
  const FocusTimerPage({super.key});

  static void show(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FocusTimerPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        opaque: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerData = ref.watch(focusTimerProvider);
    final notifier = ref.read(focusTimerProvider.notifier);

    final minutes = timerData.remainingSeconds ~/ 60;
    final seconds = timerData.remainingSeconds % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    timerData.isBreak ? '休息時間' : '專注時間',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const Spacer(),

            // Timer ring
            SizedBox(
              width: 250,
              height: 250,
              child: CustomPaint(
                painter: _TimerRingPainter(
                  progress: timerData.progress,
                  isBreak: timerData.isBreak,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeStr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timerData.isBreak
                            ? 'Break Time'
                            : 'Focus Time Remaining',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacingXl),

            // Controls
            if (timerData.state == TimerState.running)
              _buildPauseButton(notifier)
            else if (timerData.state == TimerState.paused)
              _buildResumeButton(notifier)
            else
              _buildStartButton(notifier),

            const SizedBox(height: AppTheme.spacingMd),

            // Stop + Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: notifier.stop,
                  child: const Text(
                    'Stop',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingXl),
                TextButton(
                  onPressed: notifier.reset,
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Mode switch hint
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingXl),
              child: Text(
                timerData.isBreak
                    ? '下次專注: ${timerData.focusDurationMinutes} 分鐘'
                    : '下次休息: ${timerData.breakDurationMinutes} 分鐘',
                style: const TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(FocusTimerNotifier notifier) {
    return GestureDetector(
      onTap: notifier.start,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B6B), AppTheme.accentPrimary],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusButton),
          boxShadow: AppTheme.shadowGlow,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '開始專注',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPauseButton(FocusTimerNotifier notifier) {
    return GestureDetector(
      onTap: notifier.pause,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusButton),
          border: Border.all(color: Colors.white24),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pause, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '暫停',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeButton(FocusTimerNotifier notifier) {
    return GestureDetector(
      onTap: notifier.start,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B6B), AppTheme.accentPrimary],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusButton),
          boxShadow: AppTheme.shadowGlow,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '繼續',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final bool isBreak;

  _TimerRingPainter({required this.progress, required this.isBreak});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    // Background ring
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF6B6B), AppTheme.accentPrimary],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
