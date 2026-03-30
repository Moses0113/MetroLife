import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/repositories/export_service.dart';
import 'package:metrolife/domain/providers/database_provider.dart';

final exportServiceProvider = Provider<ExportService>((ref) {
  final db = ref.watch(databaseProvider);
  return ExportService(db);
});
