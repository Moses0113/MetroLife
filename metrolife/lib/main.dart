import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/theme_provider.dart';
import 'package:metrolife/presentation/pages/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MetroLifeApp()));
}

class MetroLifeApp extends ConsumerWidget {
  const MetroLifeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'MetroLife',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'HK')],
      locale: const Locale('zh', 'HK'),
      home: const MainShell(),
    );
  }
}
