/// User Profile Provider (height/weight/username sync)
/// 參考: prd.md Section 3.5
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String username;
  final double heightCm;
  final double weightKg;
  final int settlementDay;
  final int salaryDay;
  final double monthlySalary;

  const UserProfile({
    this.username = 'User',
    this.heightCm = 0,
    this.weightKg = 0,
    this.settlementDay = 1,
    this.salaryDay = 1,
    this.monthlySalary = 0,
  });

  UserProfile copyWith({
    String? username,
    double? heightCm,
    double? weightKg,
    int? settlementDay,
    int? salaryDay,
    double? monthlySalary,
  }) {
    return UserProfile(
      username: username ?? this.username,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      settlementDay: settlementDay ?? this.settlementDay,
      salaryDay: salaryDay ?? this.salaryDay,
      monthlySalary: monthlySalary ?? this.monthlySalary,
    );
  }
}

class UserProfileNotifier extends Notifier<UserProfile> {
  bool _usernameSet = false;

  @override
  UserProfile build() {
    _load();
    return const UserProfile();
  }

  Future<void> reset() async {
    _usernameSet = false;
    state = const UserProfile();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final settlementDay = prefs.getInt('settlement_day') ?? 1;
    final salaryDay = prefs.getInt('salary_day') ?? 1;
    final monthlySalary = prefs.getDouble('monthly_salary') ?? 0;
    if (!_usernameSet) {
      state = UserProfile(
        username: prefs.getString('username') ?? 'User',
        heightCm: prefs.getDouble('height_cm') ?? 0,
        weightKg: prefs.getDouble('weight_kg') ?? 0,
        settlementDay: settlementDay,
        salaryDay: salaryDay,
        monthlySalary: monthlySalary,
      );
    } else {
      state = UserProfile(
        username: state.username,
        heightCm: prefs.getDouble('height_cm') ?? 0,
        weightKg: prefs.getDouble('weight_kg') ?? 0,
        settlementDay: settlementDay,
        salaryDay: salaryDay,
        monthlySalary: monthlySalary,
      );
    }
  }

  Future<void> updateUsername(String name) async {
    _usernameSet = true;
    state = state.copyWith(username: name);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
  }

  Future<void> updateHeight(double cm) async {
    state = state.copyWith(heightCm: cm);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height_cm', cm);
  }

  Future<void> updateWeight(double kg) async {
    state = state.copyWith(weightKg: kg);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight_kg', kg);
  }

  Future<void> updateSettlementDay(int day) async {
    final validDay = day.clamp(1, 31);
    state = state.copyWith(settlementDay: validDay);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('settlement_day', validDay);
  }

  Future<void> updateSalaryDay(int day) async {
    final validDay = day.clamp(1, 31);
    state = state.copyWith(salaryDay: validDay);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('salary_day', validDay);
  }

  Future<void> updateMonthlySalary(double amount) async {
    state = state.copyWith(monthlySalary: amount);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('monthly_salary', amount);
  }
}

final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfile>(
  UserProfileNotifier.new,
);
