#!/bin/bash
# MetroLife 一鍵代碼生成腳本
# 參考: development.md Section 6.1

echo "🚀 Generating MetroLife Code..."

# 1. 清理舊生成文件
echo "🧹 Cleaning old generated files..."
flutter clean
rm -rf lib/**/*.g.dart lib/**/*.freezed.dart lib/generated/*.dart 2>/dev/null

# 2. 獲取依賴
echo "📦 Getting dependencies..."
flutter pub get

# 3. 生成本地化
echo "🌐 Generating localizations..."
flutter gen-l10n

# 4. 生成 Drift Database
echo "💾 Generating Drift Database..."
dart run drift_dev generate

# 5. 生成所有 (Freezed, Retrofit, Riverpod, AutoRoute, JSON)
echo "🏗️ Running build_runner..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ All generated! Ready for build."
