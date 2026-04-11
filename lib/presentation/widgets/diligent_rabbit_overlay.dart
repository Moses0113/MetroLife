/// 勤力兔 Overlay 組件
/// 參考: prd.md Section 6.2-6.3, UI.md Section 4.2
library;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/core/utils/rabbit_svg.dart';

/// 場景類型
enum RabbitScene {
  todoComplete,
  incomeAdded,
  focusComplete,
  achievementBronze,
  achievementSilver,
  achievementGold,
  firstLaunch,
  error,
}

/// 顯示勤力兔 Overlay
class DiligentRabbitOverlay {
  static OverlayEntry? _currentEntry;

  /// 顯示勤力兔彈出動畫
  static void show(
    BuildContext context, {
    required RabbitScene scene,
    int? focusMinutes,
    int? breakMinutes,
  }) {
    // Remove any existing overlay
    hide();

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _RabbitOverlayContent(
        scene: scene,
        focusMinutes: focusMinutes,
        breakMinutes: breakMinutes,
        onDismiss: hide,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  /// 隱藏當前 overlay
  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _RabbitOverlayContent extends StatefulWidget {
  const _RabbitOverlayContent({
    required this.scene,
    this.focusMinutes,
    this.breakMinutes,
    required this.onDismiss,
  });

  final RabbitScene scene;
  final int? focusMinutes;
  final int? breakMinutes;
  final VoidCallback onDismiss;

  @override
  State<_RabbitOverlayContent> createState() => _RabbitOverlayContentState();
}

class _RabbitOverlayContentState extends State<_RabbitOverlayContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    _controller.forward();
    _confettiController.play();

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = _getMessage();
    final rabbitType = _getRabbitType();
    final showConfetti =
        widget.scene == RabbitScene.achievementGold ||
        widget.scene == RabbitScene.achievementSilver ||
        widget.scene == RabbitScene.focusComplete;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnim.value,
          child: GestureDetector(
            onTap: _dismiss,
            child: Container(
              color: Colors.black.withValues(alpha: 0.3 * _fadeAnim.value),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Speech bubble
                        Transform.scale(
                          scale: _scaleAnim.value,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingXl,
                            ),
                            padding: const EdgeInsets.all(AppTheme.spacingLg),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppTheme.shadowLg,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        // Rabbit
                        Transform.scale(
                          scale: _scaleAnim.value,
                          child: RabbitSvgWidget(
                            type: rabbitType,
                            size: _getRabbitSize(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Confetti
                  if (showConfetti)
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                        colors: const [
                          AppTheme.accentSecondary,
                          AppTheme.accentPrimary,
                          Colors.green,
                          Colors.blue,
                        ],
                        numberOfParticles: 20,
                        gravity: 0.3,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getMessage() {
    final rand = Random().nextInt(3);

    switch (widget.scene) {
      case RabbitScene.todoComplete:
        final msgs = ['做得好！又完成一件 💪', '效率滿分！繼續保持 🌟', '清單又短了，輕鬆曬～'];
        return msgs[rand];

      case RabbitScene.incomeAdded:
        final msgs = ['距離億萬富翁又一步 💰', '準備去環遊世界吧 ✈️', '又有進帳了，繼續努力 ^_^'];
        return msgs[rand];

      case RabbitScene.focusComplete:
        final m = widget.focusMinutes ?? 25;
        final b = widget.breakMinutes ?? 5;
        return '恭喜你，成功專注 $m 分鐘，休息 $b 分鐘。飲杯水先啦～';

      case RabbitScene.achievementBronze:
        return '連續 3 天運動！你是真正的勤力兔！🏅';

      case RabbitScene.achievementSilver:
        return '連續 7 天運動！你是真正的勤力兔！🏅';

      case RabbitScene.achievementGold:
        return '連續 30 天運動！你是傳奇勤力兔！🏆';

      case RabbitScene.firstLaunch:
        return '你好！我係勤力兔，一齊打理生活啦！';

      case RabbitScene.error:
        return '哎呀，出了點問題，再試一次好嗎？';
    }
  }

  String _getRabbitType() {
    switch (widget.scene) {
      case RabbitScene.incomeAdded:
        return 'money';
      case RabbitScene.focusComplete:
      case RabbitScene.achievementSilver:
      case RabbitScene.achievementGold:
        return 'celebrate';
      case RabbitScene.achievementBronze:
        return 'thumbs_up';
      case RabbitScene.error:
        return 'surprised';
      default:
        return 'idle';
    }
  }

  double _getRabbitSize() {
    switch (widget.scene) {
      case RabbitScene.focusComplete:
      case RabbitScene.achievementGold:
        return 180;
      case RabbitScene.achievementSilver:
        return 160;
      default:
        return 140;
    }
  }
}
