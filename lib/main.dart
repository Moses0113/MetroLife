import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/theme_provider.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';
import 'package:metrolife/domain/providers/transaction_provider.dart';
import 'package:metrolife/presentation/pages/main_shell.dart';
import 'package:metrolife/presentation/pages/welcome_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MetroLifeApp()));
}

class MetroLifeApp extends ConsumerStatefulWidget {
  const MetroLifeApp({super.key});

  @override
  ConsumerState<MetroLifeApp> createState() => _MetroLifeAppState();
}

class _MetroLifeAppState extends ConsumerState<MetroLifeApp> {
  bool _loading = true;
  bool _showWelcome = false;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompleted = prefs.getBool('has_completed_welcome') ?? false;
    setState(() {
      _showWelcome = !hasCompleted;
      _loading = false;
    });
    _tryAutoSalary();
  }

  Future<void> _tryAutoSalary() async {
    final profile = ref.read(userProfileProvider);
    if (profile.monthlySalary > 0) {
      await ref
          .read(transactionServiceProvider)
          .checkAutoSalary(
            salaryDay: profile.salaryDay,
            monthlySalary: profile.monthlySalary,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      home: _loading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _showWelcome
          ? WelcomePage(
              onComplete: () {
                setState(() => _showWelcome = false);
              },
            )
          : const MainShell(),
    );
  }
}
