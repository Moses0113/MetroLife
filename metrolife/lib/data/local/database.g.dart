// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class HealthSyncLogs extends Table
    with TableInfo<HealthSyncLogs, HealthSyncLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  HealthSyncLogs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _syncTimeMeta = const VerificationMeta(
    'syncTime',
  );
  late final GeneratedColumn<int> syncTime = GeneratedColumn<int>(
    'sync_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _syncTypeMeta = const VerificationMeta(
    'syncType',
  );
  late final GeneratedColumn<String> syncType = GeneratedColumn<String>(
    'sync_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _recordsCountMeta = const VerificationMeta(
    'recordsCount',
  );
  late final GeneratedColumn<int> recordsCount = GeneratedColumn<int>(
    'records_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncTime,
    platform,
    syncType,
    status,
    recordsCount,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_sync_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthSyncLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_time')) {
      context.handle(
        _syncTimeMeta,
        syncTime.isAcceptableOrUnknown(data['sync_time']!, _syncTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTimeMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('sync_type')) {
      context.handle(
        _syncTypeMeta,
        syncType.isAcceptableOrUnknown(data['sync_type']!, _syncTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('records_count')) {
      context.handle(
        _recordsCountMeta,
        recordsCount.isAcceptableOrUnknown(
          data['records_count']!,
          _recordsCountMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthSyncLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthSyncLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_time'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      syncType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      recordsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_count'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  HealthSyncLogs createAlias(String alias) {
    return HealthSyncLogs(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class HealthSyncLog extends DataClass implements Insertable<HealthSyncLog> {
  final int id;
  final int syncTime;
  final String platform;
  final String syncType;
  final String status;
  final int? recordsCount;
  final String? errorMessage;
  const HealthSyncLog({
    required this.id,
    required this.syncTime,
    required this.platform,
    required this.syncType,
    required this.status,
    this.recordsCount,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_time'] = Variable<int>(syncTime);
    map['platform'] = Variable<String>(platform);
    map['sync_type'] = Variable<String>(syncType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || recordsCount != null) {
      map['records_count'] = Variable<int>(recordsCount);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  HealthSyncLogsCompanion toCompanion(bool nullToAbsent) {
    return HealthSyncLogsCompanion(
      id: Value(id),
      syncTime: Value(syncTime),
      platform: Value(platform),
      syncType: Value(syncType),
      status: Value(status),
      recordsCount: recordsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(recordsCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory HealthSyncLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthSyncLog(
      id: serializer.fromJson<int>(json['id']),
      syncTime: serializer.fromJson<int>(json['sync_time']),
      platform: serializer.fromJson<String>(json['platform']),
      syncType: serializer.fromJson<String>(json['sync_type']),
      status: serializer.fromJson<String>(json['status']),
      recordsCount: serializer.fromJson<int?>(json['records_count']),
      errorMessage: serializer.fromJson<String?>(json['error_message']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sync_time': serializer.toJson<int>(syncTime),
      'platform': serializer.toJson<String>(platform),
      'sync_type': serializer.toJson<String>(syncType),
      'status': serializer.toJson<String>(status),
      'records_count': serializer.toJson<int?>(recordsCount),
      'error_message': serializer.toJson<String?>(errorMessage),
    };
  }

  HealthSyncLog copyWith({
    int? id,
    int? syncTime,
    String? platform,
    String? syncType,
    String? status,
    Value<int?> recordsCount = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
  }) => HealthSyncLog(
    id: id ?? this.id,
    syncTime: syncTime ?? this.syncTime,
    platform: platform ?? this.platform,
    syncType: syncType ?? this.syncType,
    status: status ?? this.status,
    recordsCount: recordsCount.present ? recordsCount.value : this.recordsCount,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  HealthSyncLog copyWithCompanion(HealthSyncLogsCompanion data) {
    return HealthSyncLog(
      id: data.id.present ? data.id.value : this.id,
      syncTime: data.syncTime.present ? data.syncTime.value : this.syncTime,
      platform: data.platform.present ? data.platform.value : this.platform,
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      status: data.status.present ? data.status.value : this.status,
      recordsCount: data.recordsCount.present
          ? data.recordsCount.value
          : this.recordsCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthSyncLog(')
          ..write('id: $id, ')
          ..write('syncTime: $syncTime, ')
          ..write('platform: $platform, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('recordsCount: $recordsCount, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTime,
    platform,
    syncType,
    status,
    recordsCount,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthSyncLog &&
          other.id == this.id &&
          other.syncTime == this.syncTime &&
          other.platform == this.platform &&
          other.syncType == this.syncType &&
          other.status == this.status &&
          other.recordsCount == this.recordsCount &&
          other.errorMessage == this.errorMessage);
}

class HealthSyncLogsCompanion extends UpdateCompanion<HealthSyncLog> {
  final Value<int> id;
  final Value<int> syncTime;
  final Value<String> platform;
  final Value<String> syncType;
  final Value<String> status;
  final Value<int?> recordsCount;
  final Value<String?> errorMessage;
  const HealthSyncLogsCompanion({
    this.id = const Value.absent(),
    this.syncTime = const Value.absent(),
    this.platform = const Value.absent(),
    this.syncType = const Value.absent(),
    this.status = const Value.absent(),
    this.recordsCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  HealthSyncLogsCompanion.insert({
    this.id = const Value.absent(),
    required int syncTime,
    required String platform,
    required String syncType,
    required String status,
    this.recordsCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
  }) : syncTime = Value(syncTime),
       platform = Value(platform),
       syncType = Value(syncType),
       status = Value(status);
  static Insertable<HealthSyncLog> custom({
    Expression<int>? id,
    Expression<int>? syncTime,
    Expression<String>? platform,
    Expression<String>? syncType,
    Expression<String>? status,
    Expression<int>? recordsCount,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTime != null) 'sync_time': syncTime,
      if (platform != null) 'platform': platform,
      if (syncType != null) 'sync_type': syncType,
      if (status != null) 'status': status,
      if (recordsCount != null) 'records_count': recordsCount,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  HealthSyncLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? syncTime,
    Value<String>? platform,
    Value<String>? syncType,
    Value<String>? status,
    Value<int?>? recordsCount,
    Value<String?>? errorMessage,
  }) {
    return HealthSyncLogsCompanion(
      id: id ?? this.id,
      syncTime: syncTime ?? this.syncTime,
      platform: platform ?? this.platform,
      syncType: syncType ?? this.syncType,
      status: status ?? this.status,
      recordsCount: recordsCount ?? this.recordsCount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTime.present) {
      map['sync_time'] = Variable<int>(syncTime.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (syncType.present) {
      map['sync_type'] = Variable<String>(syncType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (recordsCount.present) {
      map['records_count'] = Variable<int>(recordsCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthSyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('syncTime: $syncTime, ')
          ..write('platform: $platform, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('recordsCount: $recordsCount, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

class RabbitAchievements extends Table
    with TableInfo<RabbitAchievements, RabbitAchievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RabbitAchievements(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  late final GeneratedColumn<int> achievedAt = GeneratedColumn<int>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _shownToUserMeta = const VerificationMeta(
    'shownToUser',
  );
  late final GeneratedColumn<int> shownToUser = GeneratedColumn<int>(
    'shown_to_user',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, achievedAt, shownToUser];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rabbit_achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<RabbitAchievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    if (data.containsKey('shown_to_user')) {
      context.handle(
        _shownToUserMeta,
        shownToUser.isAcceptableOrUnknown(
          data['shown_to_user']!,
          _shownToUserMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RabbitAchievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RabbitAchievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}achieved_at'],
      )!,
      shownToUser: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shown_to_user'],
      )!,
    );
  }

  @override
  RabbitAchievements createAlias(String alias) {
    return RabbitAchievements(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RabbitAchievement extends DataClass
    implements Insertable<RabbitAchievement> {
  final String id;
  final String type;
  final int achievedAt;
  final int shownToUser;
  const RabbitAchievement({
    required this.id,
    required this.type,
    required this.achievedAt,
    required this.shownToUser,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['achieved_at'] = Variable<int>(achievedAt);
    map['shown_to_user'] = Variable<int>(shownToUser);
    return map;
  }

  RabbitAchievementsCompanion toCompanion(bool nullToAbsent) {
    return RabbitAchievementsCompanion(
      id: Value(id),
      type: Value(type),
      achievedAt: Value(achievedAt),
      shownToUser: Value(shownToUser),
    );
  }

  factory RabbitAchievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RabbitAchievement(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      achievedAt: serializer.fromJson<int>(json['achieved_at']),
      shownToUser: serializer.fromJson<int>(json['shown_to_user']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'achieved_at': serializer.toJson<int>(achievedAt),
      'shown_to_user': serializer.toJson<int>(shownToUser),
    };
  }

  RabbitAchievement copyWith({
    String? id,
    String? type,
    int? achievedAt,
    int? shownToUser,
  }) => RabbitAchievement(
    id: id ?? this.id,
    type: type ?? this.type,
    achievedAt: achievedAt ?? this.achievedAt,
    shownToUser: shownToUser ?? this.shownToUser,
  );
  RabbitAchievement copyWithCompanion(RabbitAchievementsCompanion data) {
    return RabbitAchievement(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
      shownToUser: data.shownToUser.present
          ? data.shownToUser.value
          : this.shownToUser,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RabbitAchievement(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('shownToUser: $shownToUser')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, achievedAt, shownToUser);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RabbitAchievement &&
          other.id == this.id &&
          other.type == this.type &&
          other.achievedAt == this.achievedAt &&
          other.shownToUser == this.shownToUser);
}

class RabbitAchievementsCompanion extends UpdateCompanion<RabbitAchievement> {
  final Value<String> id;
  final Value<String> type;
  final Value<int> achievedAt;
  final Value<int> shownToUser;
  final Value<int> rowid;
  const RabbitAchievementsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.shownToUser = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RabbitAchievementsCompanion.insert({
    required String id,
    required String type,
    required int achievedAt,
    this.shownToUser = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       achievedAt = Value(achievedAt);
  static Insertable<RabbitAchievement> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? achievedAt,
    Expression<int>? shownToUser,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (shownToUser != null) 'shown_to_user': shownToUser,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RabbitAchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<int>? achievedAt,
    Value<int>? shownToUser,
    Value<int>? rowid,
  }) {
    return RabbitAchievementsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      achievedAt: achievedAt ?? this.achievedAt,
      shownToUser: shownToUser ?? this.shownToUser,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<int>(achievedAt.value);
    }
    if (shownToUser.present) {
      map['shown_to_user'] = Variable<int>(shownToUser.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RabbitAchievementsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('shownToUser: $shownToUser, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ExerciseRecords extends Table
    with TableInfo<ExerciseRecords, ExerciseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ExerciseRecords(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _routeJsonMeta = const VerificationMeta(
    'routeJson',
  );
  late final GeneratedColumn<String> routeJson = GeneratedColumn<String>(
    'route_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _encodedPolylineMeta = const VerificationMeta(
    'encodedPolyline',
  );
  late final GeneratedColumn<String> encodedPolyline = GeneratedColumn<String>(
    'encoded_polyline',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _caloriesBurnedMeta = const VerificationMeta(
    'caloriesBurned',
  );
  late final GeneratedColumn<double> caloriesBurned = GeneratedColumn<double>(
    'calories_burned',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _weightAtTimeKgMeta = const VerificationMeta(
    'weightAtTimeKg',
  );
  late final GeneratedColumn<double> weightAtTimeKg = GeneratedColumn<double>(
    'weight_at_time_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _syncedToHealthMeta = const VerificationMeta(
    'syncedToHealth',
  );
  late final GeneratedColumn<int> syncedToHealth = GeneratedColumn<int>(
    'synced_to_health',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _healthPlatformIdMeta = const VerificationMeta(
    'healthPlatformId',
  );
  late final GeneratedColumn<String> healthPlatformId = GeneratedColumn<String>(
    'health_platform_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    startTime,
    durationSeconds,
    distanceKm,
    routeJson,
    encodedPolyline,
    steps,
    caloriesBurned,
    weightAtTimeKg,
    syncedToHealth,
    healthPlatformId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    }
    if (data.containsKey('route_json')) {
      context.handle(
        _routeJsonMeta,
        routeJson.isAcceptableOrUnknown(data['route_json']!, _routeJsonMeta),
      );
    }
    if (data.containsKey('encoded_polyline')) {
      context.handle(
        _encodedPolylineMeta,
        encodedPolyline.isAcceptableOrUnknown(
          data['encoded_polyline']!,
          _encodedPolylineMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
        _caloriesBurnedMeta,
        caloriesBurned.isAcceptableOrUnknown(
          data['calories_burned']!,
          _caloriesBurnedMeta,
        ),
      );
    }
    if (data.containsKey('weight_at_time_kg')) {
      context.handle(
        _weightAtTimeKgMeta,
        weightAtTimeKg.isAcceptableOrUnknown(
          data['weight_at_time_kg']!,
          _weightAtTimeKgMeta,
        ),
      );
    }
    if (data.containsKey('synced_to_health')) {
      context.handle(
        _syncedToHealthMeta,
        syncedToHealth.isAcceptableOrUnknown(
          data['synced_to_health']!,
          _syncedToHealthMeta,
        ),
      );
    }
    if (data.containsKey('health_platform_id')) {
      context.handle(
        _healthPlatformIdMeta,
        healthPlatformId.isAcceptableOrUnknown(
          data['health_platform_id']!,
          _healthPlatformIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_time'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      ),
      routeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_json'],
      ),
      encodedPolyline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encoded_polyline'],
      ),
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      ),
      caloriesBurned: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_burned'],
      ),
      weightAtTimeKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_at_time_kg'],
      ),
      syncedToHealth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}synced_to_health'],
      )!,
      healthPlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}health_platform_id'],
      ),
    );
  }

  @override
  ExerciseRecords createAlias(String alias) {
    return ExerciseRecords(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ExerciseRecord extends DataClass implements Insertable<ExerciseRecord> {
  final String id;
  final String type;
  final int? startTime;
  final int? durationSeconds;
  final double? distanceKm;
  final String? routeJson;
  final String? encodedPolyline;
  final int? steps;
  final double? caloriesBurned;
  final double? weightAtTimeKg;
  final int syncedToHealth;
  final String? healthPlatformId;
  const ExerciseRecord({
    required this.id,
    required this.type,
    this.startTime,
    this.durationSeconds,
    this.distanceKm,
    this.routeJson,
    this.encodedPolyline,
    this.steps,
    this.caloriesBurned,
    this.weightAtTimeKg,
    required this.syncedToHealth,
    this.healthPlatformId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<int>(startTime);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    if (!nullToAbsent || routeJson != null) {
      map['route_json'] = Variable<String>(routeJson);
    }
    if (!nullToAbsent || encodedPolyline != null) {
      map['encoded_polyline'] = Variable<String>(encodedPolyline);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<double>(caloriesBurned);
    }
    if (!nullToAbsent || weightAtTimeKg != null) {
      map['weight_at_time_kg'] = Variable<double>(weightAtTimeKg);
    }
    map['synced_to_health'] = Variable<int>(syncedToHealth);
    if (!nullToAbsent || healthPlatformId != null) {
      map['health_platform_id'] = Variable<String>(healthPlatformId);
    }
    return map;
  }

  ExerciseRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseRecordsCompanion(
      id: Value(id),
      type: Value(type),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      routeJson: routeJson == null && nullToAbsent
          ? const Value.absent()
          : Value(routeJson),
      encodedPolyline: encodedPolyline == null && nullToAbsent
          ? const Value.absent()
          : Value(encodedPolyline),
      steps: steps == null && nullToAbsent
          ? const Value.absent()
          : Value(steps),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      weightAtTimeKg: weightAtTimeKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightAtTimeKg),
      syncedToHealth: Value(syncedToHealth),
      healthPlatformId: healthPlatformId == null && nullToAbsent
          ? const Value.absent()
          : Value(healthPlatformId),
    );
  }

  factory ExerciseRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRecord(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      startTime: serializer.fromJson<int?>(json['start_time']),
      durationSeconds: serializer.fromJson<int?>(json['duration_seconds']),
      distanceKm: serializer.fromJson<double?>(json['distance_km']),
      routeJson: serializer.fromJson<String?>(json['route_json']),
      encodedPolyline: serializer.fromJson<String?>(json['encoded_polyline']),
      steps: serializer.fromJson<int?>(json['steps']),
      caloriesBurned: serializer.fromJson<double?>(json['calories_burned']),
      weightAtTimeKg: serializer.fromJson<double?>(json['weight_at_time_kg']),
      syncedToHealth: serializer.fromJson<int>(json['synced_to_health']),
      healthPlatformId: serializer.fromJson<String?>(
        json['health_platform_id'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'start_time': serializer.toJson<int?>(startTime),
      'duration_seconds': serializer.toJson<int?>(durationSeconds),
      'distance_km': serializer.toJson<double?>(distanceKm),
      'route_json': serializer.toJson<String?>(routeJson),
      'encoded_polyline': serializer.toJson<String?>(encodedPolyline),
      'steps': serializer.toJson<int?>(steps),
      'calories_burned': serializer.toJson<double?>(caloriesBurned),
      'weight_at_time_kg': serializer.toJson<double?>(weightAtTimeKg),
      'synced_to_health': serializer.toJson<int>(syncedToHealth),
      'health_platform_id': serializer.toJson<String?>(healthPlatformId),
    };
  }

  ExerciseRecord copyWith({
    String? id,
    String? type,
    Value<int?> startTime = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<double?> distanceKm = const Value.absent(),
    Value<String?> routeJson = const Value.absent(),
    Value<String?> encodedPolyline = const Value.absent(),
    Value<int?> steps = const Value.absent(),
    Value<double?> caloriesBurned = const Value.absent(),
    Value<double?> weightAtTimeKg = const Value.absent(),
    int? syncedToHealth,
    Value<String?> healthPlatformId = const Value.absent(),
  }) => ExerciseRecord(
    id: id ?? this.id,
    type: type ?? this.type,
    startTime: startTime.present ? startTime.value : this.startTime,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
    routeJson: routeJson.present ? routeJson.value : this.routeJson,
    encodedPolyline: encodedPolyline.present
        ? encodedPolyline.value
        : this.encodedPolyline,
    steps: steps.present ? steps.value : this.steps,
    caloriesBurned: caloriesBurned.present
        ? caloriesBurned.value
        : this.caloriesBurned,
    weightAtTimeKg: weightAtTimeKg.present
        ? weightAtTimeKg.value
        : this.weightAtTimeKg,
    syncedToHealth: syncedToHealth ?? this.syncedToHealth,
    healthPlatformId: healthPlatformId.present
        ? healthPlatformId.value
        : this.healthPlatformId,
  );
  ExerciseRecord copyWithCompanion(ExerciseRecordsCompanion data) {
    return ExerciseRecord(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      routeJson: data.routeJson.present ? data.routeJson.value : this.routeJson,
      encodedPolyline: data.encodedPolyline.present
          ? data.encodedPolyline.value
          : this.encodedPolyline,
      steps: data.steps.present ? data.steps.value : this.steps,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      weightAtTimeKg: data.weightAtTimeKg.present
          ? data.weightAtTimeKg.value
          : this.weightAtTimeKg,
      syncedToHealth: data.syncedToHealth.present
          ? data.syncedToHealth.value
          : this.syncedToHealth,
      healthPlatformId: data.healthPlatformId.present
          ? data.healthPlatformId.value
          : this.healthPlatformId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecord(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('routeJson: $routeJson, ')
          ..write('encodedPolyline: $encodedPolyline, ')
          ..write('steps: $steps, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('weightAtTimeKg: $weightAtTimeKg, ')
          ..write('syncedToHealth: $syncedToHealth, ')
          ..write('healthPlatformId: $healthPlatformId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    startTime,
    durationSeconds,
    distanceKm,
    routeJson,
    encodedPolyline,
    steps,
    caloriesBurned,
    weightAtTimeKg,
    syncedToHealth,
    healthPlatformId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRecord &&
          other.id == this.id &&
          other.type == this.type &&
          other.startTime == this.startTime &&
          other.durationSeconds == this.durationSeconds &&
          other.distanceKm == this.distanceKm &&
          other.routeJson == this.routeJson &&
          other.encodedPolyline == this.encodedPolyline &&
          other.steps == this.steps &&
          other.caloriesBurned == this.caloriesBurned &&
          other.weightAtTimeKg == this.weightAtTimeKg &&
          other.syncedToHealth == this.syncedToHealth &&
          other.healthPlatformId == this.healthPlatformId);
}

class ExerciseRecordsCompanion extends UpdateCompanion<ExerciseRecord> {
  final Value<String> id;
  final Value<String> type;
  final Value<int?> startTime;
  final Value<int?> durationSeconds;
  final Value<double?> distanceKm;
  final Value<String?> routeJson;
  final Value<String?> encodedPolyline;
  final Value<int?> steps;
  final Value<double?> caloriesBurned;
  final Value<double?> weightAtTimeKg;
  final Value<int> syncedToHealth;
  final Value<String?> healthPlatformId;
  final Value<int> rowid;
  const ExerciseRecordsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.startTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.routeJson = const Value.absent(),
    this.encodedPolyline = const Value.absent(),
    this.steps = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.weightAtTimeKg = const Value.absent(),
    this.syncedToHealth = const Value.absent(),
    this.healthPlatformId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseRecordsCompanion.insert({
    required String id,
    required String type,
    this.startTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.routeJson = const Value.absent(),
    this.encodedPolyline = const Value.absent(),
    this.steps = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.weightAtTimeKg = const Value.absent(),
    this.syncedToHealth = const Value.absent(),
    this.healthPlatformId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type);
  static Insertable<ExerciseRecord> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? startTime,
    Expression<int>? durationSeconds,
    Expression<double>? distanceKm,
    Expression<String>? routeJson,
    Expression<String>? encodedPolyline,
    Expression<int>? steps,
    Expression<double>? caloriesBurned,
    Expression<double>? weightAtTimeKg,
    Expression<int>? syncedToHealth,
    Expression<String>? healthPlatformId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (startTime != null) 'start_time': startTime,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (routeJson != null) 'route_json': routeJson,
      if (encodedPolyline != null) 'encoded_polyline': encodedPolyline,
      if (steps != null) 'steps': steps,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (weightAtTimeKg != null) 'weight_at_time_kg': weightAtTimeKg,
      if (syncedToHealth != null) 'synced_to_health': syncedToHealth,
      if (healthPlatformId != null) 'health_platform_id': healthPlatformId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<int?>? startTime,
    Value<int?>? durationSeconds,
    Value<double?>? distanceKm,
    Value<String?>? routeJson,
    Value<String?>? encodedPolyline,
    Value<int?>? steps,
    Value<double?>? caloriesBurned,
    Value<double?>? weightAtTimeKg,
    Value<int>? syncedToHealth,
    Value<String?>? healthPlatformId,
    Value<int>? rowid,
  }) {
    return ExerciseRecordsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      distanceKm: distanceKm ?? this.distanceKm,
      routeJson: routeJson ?? this.routeJson,
      encodedPolyline: encodedPolyline ?? this.encodedPolyline,
      steps: steps ?? this.steps,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      weightAtTimeKg: weightAtTimeKg ?? this.weightAtTimeKg,
      syncedToHealth: syncedToHealth ?? this.syncedToHealth,
      healthPlatformId: healthPlatformId ?? this.healthPlatformId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (routeJson.present) {
      map['route_json'] = Variable<String>(routeJson.value);
    }
    if (encodedPolyline.present) {
      map['encoded_polyline'] = Variable<String>(encodedPolyline.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<double>(caloriesBurned.value);
    }
    if (weightAtTimeKg.present) {
      map['weight_at_time_kg'] = Variable<double>(weightAtTimeKg.value);
    }
    if (syncedToHealth.present) {
      map['synced_to_health'] = Variable<int>(syncedToHealth.value);
    }
    if (healthPlatformId.present) {
      map['health_platform_id'] = Variable<String>(healthPlatformId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('routeJson: $routeJson, ')
          ..write('encodedPolyline: $encodedPolyline, ')
          ..write('steps: $steps, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('weightAtTimeKg: $weightAtTimeKg, ')
          ..write('syncedToHealth: $syncedToHealth, ')
          ..write('healthPlatformId: $healthPlatformId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DiaryEntries extends Table with TableInfo<DiaryEntries, DiaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DiaryEntries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (mood BETWEEN 1 AND 5)',
  );
  static const VerificationMeta _imagePathsMeta = const VerificationMeta(
    'imagePaths',
  );
  late final GeneratedColumn<String> imagePaths = GeneratedColumn<String>(
    'image_paths',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _linkedEventIdMeta = const VerificationMeta(
    'linkedEventId',
  );
  late final GeneratedColumn<String> linkedEventId = GeneratedColumn<String>(
    'linked_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    content,
    mood,
    imagePaths,
    linkedEventId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('image_paths')) {
      context.handle(
        _imagePathsMeta,
        imagePaths.isAcceptableOrUnknown(data['image_paths']!, _imagePathsMeta),
      );
    }
    if (data.containsKey('linked_event_id')) {
      context.handle(
        _linkedEventIdMeta,
        linkedEventId.isAcceptableOrUnknown(
          data['linked_event_id']!,
          _linkedEventIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood'],
      ),
      imagePaths: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_paths'],
      ),
      linkedEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_event_id'],
      ),
    );
  }

  @override
  DiaryEntries createAlias(String alias) {
    return DiaryEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DiaryEntry extends DataClass implements Insertable<DiaryEntry> {
  final String id;
  final String date;
  final String? content;
  final int? mood;
  final String? imagePaths;
  final String? linkedEventId;
  const DiaryEntry({
    required this.id,
    required this.date,
    this.content,
    this.mood,
    this.imagePaths,
    this.linkedEventId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<int>(mood);
    }
    if (!nullToAbsent || imagePaths != null) {
      map['image_paths'] = Variable<String>(imagePaths);
    }
    if (!nullToAbsent || linkedEventId != null) {
      map['linked_event_id'] = Variable<String>(linkedEventId);
    }
    return map;
  }

  DiaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DiaryEntriesCompanion(
      id: Value(id),
      date: Value(date),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      imagePaths: imagePaths == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePaths),
      linkedEventId: linkedEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEventId),
    );
  }

  factory DiaryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryEntry(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      content: serializer.fromJson<String?>(json['content']),
      mood: serializer.fromJson<int?>(json['mood']),
      imagePaths: serializer.fromJson<String?>(json['image_paths']),
      linkedEventId: serializer.fromJson<String?>(json['linked_event_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'content': serializer.toJson<String?>(content),
      'mood': serializer.toJson<int?>(mood),
      'image_paths': serializer.toJson<String?>(imagePaths),
      'linked_event_id': serializer.toJson<String?>(linkedEventId),
    };
  }

  DiaryEntry copyWith({
    String? id,
    String? date,
    Value<String?> content = const Value.absent(),
    Value<int?> mood = const Value.absent(),
    Value<String?> imagePaths = const Value.absent(),
    Value<String?> linkedEventId = const Value.absent(),
  }) => DiaryEntry(
    id: id ?? this.id,
    date: date ?? this.date,
    content: content.present ? content.value : this.content,
    mood: mood.present ? mood.value : this.mood,
    imagePaths: imagePaths.present ? imagePaths.value : this.imagePaths,
    linkedEventId: linkedEventId.present
        ? linkedEventId.value
        : this.linkedEventId,
  );
  DiaryEntry copyWithCompanion(DiaryEntriesCompanion data) {
    return DiaryEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      content: data.content.present ? data.content.value : this.content,
      mood: data.mood.present ? data.mood.value : this.mood,
      imagePaths: data.imagePaths.present
          ? data.imagePaths.value
          : this.imagePaths,
      linkedEventId: data.linkedEventId.present
          ? data.linkedEventId.value
          : this.linkedEventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('linkedEventId: $linkedEventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, content, mood, imagePaths, linkedEventId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.content == this.content &&
          other.mood == this.mood &&
          other.imagePaths == this.imagePaths &&
          other.linkedEventId == this.linkedEventId);
}

class DiaryEntriesCompanion extends UpdateCompanion<DiaryEntry> {
  final Value<String> id;
  final Value<String> date;
  final Value<String?> content;
  final Value<int?> mood;
  final Value<String?> imagePaths;
  final Value<String?> linkedEventId;
  final Value<int> rowid;
  const DiaryEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.content = const Value.absent(),
    this.mood = const Value.absent(),
    this.imagePaths = const Value.absent(),
    this.linkedEventId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryEntriesCompanion.insert({
    required String id,
    required String date,
    this.content = const Value.absent(),
    this.mood = const Value.absent(),
    this.imagePaths = const Value.absent(),
    this.linkedEventId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date);
  static Insertable<DiaryEntry> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? content,
    Expression<int>? mood,
    Expression<String>? imagePaths,
    Expression<String>? linkedEventId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (content != null) 'content': content,
      if (mood != null) 'mood': mood,
      if (imagePaths != null) 'image_paths': imagePaths,
      if (linkedEventId != null) 'linked_event_id': linkedEventId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiaryEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? date,
    Value<String?>? content,
    Value<int?>? mood,
    Value<String?>? imagePaths,
    Value<String?>? linkedEventId,
    Value<int>? rowid,
  }) {
    return DiaryEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      imagePaths: imagePaths ?? this.imagePaths,
      linkedEventId: linkedEventId ?? this.linkedEventId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (imagePaths.present) {
      map['image_paths'] = Variable<String>(imagePaths.value);
    }
    if (linkedEventId.present) {
      map['linked_event_id'] = Variable<String>(linkedEventId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('linkedEventId: $linkedEventId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Todos extends Table with TableInfo<Todos, TodoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Todos(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  late final GeneratedColumn<int> isCompleted = GeneratedColumn<int>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'general\'',
    defaultValue: const CustomExpression('\'general\''),
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _reminderDateMeta = const VerificationMeta(
    'reminderDate',
  );
  late final GeneratedColumn<String> reminderDate = GeneratedColumn<String>(
    'reminder_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', \'now\') AS int))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', \'now\') AS int)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    dueDate,
    isCompleted,
    type,
    documentType,
    reminderDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    }
    if (data.containsKey('reminder_date')) {
      context.handle(
        _reminderDateMeta,
        reminderDate.isAcceptableOrUnknown(
          data['reminder_date']!,
          _reminderDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_completed'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      ),
      reminderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  Todos createAlias(String alias) {
    return Todos(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TodoRow extends DataClass implements Insertable<TodoRow> {
  final String id;
  final String title;
  final String? dueDate;
  final int isCompleted;
  final String type;
  final String? documentType;
  final String? reminderDate;
  final int createdAt;
  const TodoRow({
    required this.id,
    required this.title,
    this.dueDate,
    required this.isCompleted,
    required this.type,
    this.documentType,
    this.reminderDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    map['is_completed'] = Variable<int>(isCompleted);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || documentType != null) {
      map['document_type'] = Variable<String>(documentType);
    }
    if (!nullToAbsent || reminderDate != null) {
      map['reminder_date'] = Variable<String>(reminderDate);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: Value(isCompleted),
      type: Value(type),
      documentType: documentType == null && nullToAbsent
          ? const Value.absent()
          : Value(documentType),
      reminderDate: reminderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDate),
      createdAt: Value(createdAt),
    );
  }

  factory TodoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<String?>(json['due_date']),
      isCompleted: serializer.fromJson<int>(json['is_completed']),
      type: serializer.fromJson<String>(json['type']),
      documentType: serializer.fromJson<String?>(json['document_type']),
      reminderDate: serializer.fromJson<String?>(json['reminder_date']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'due_date': serializer.toJson<String?>(dueDate),
      'is_completed': serializer.toJson<int>(isCompleted),
      'type': serializer.toJson<String>(type),
      'document_type': serializer.toJson<String?>(documentType),
      'reminder_date': serializer.toJson<String?>(reminderDate),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  TodoRow copyWith({
    String? id,
    String? title,
    Value<String?> dueDate = const Value.absent(),
    int? isCompleted,
    String? type,
    Value<String?> documentType = const Value.absent(),
    Value<String?> reminderDate = const Value.absent(),
    int? createdAt,
  }) => TodoRow(
    id: id ?? this.id,
    title: title ?? this.title,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    isCompleted: isCompleted ?? this.isCompleted,
    type: type ?? this.type,
    documentType: documentType.present ? documentType.value : this.documentType,
    reminderDate: reminderDate.present ? reminderDate.value : this.reminderDate,
    createdAt: createdAt ?? this.createdAt,
  );
  TodoRow copyWithCompanion(TodosCompanion data) {
    return TodoRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      type: data.type.present ? data.type.value : this.type,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      reminderDate: data.reminderDate.present
          ? data.reminderDate.value
          : this.reminderDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('type: $type, ')
          ..write('documentType: $documentType, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    dueDate,
    isCompleted,
    type,
    documentType,
    reminderDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted &&
          other.type == this.type &&
          other.documentType == this.documentType &&
          other.reminderDate == this.reminderDate &&
          other.createdAt == this.createdAt);
}

class TodosCompanion extends UpdateCompanion<TodoRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> dueDate;
  final Value<int> isCompleted;
  final Value<String> type;
  final Value<String?> documentType;
  final Value<String?> reminderDate;
  final Value<int> createdAt;
  final Value<int> rowid;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.type = const Value.absent(),
    this.documentType = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodosCompanion.insert({
    required String id,
    required String title,
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.type = const Value.absent(),
    this.documentType = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<TodoRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? dueDate,
    Expression<int>? isCompleted,
    Expression<String>? type,
    Expression<String>? documentType,
    Expression<String>? reminderDate,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (type != null) 'type': type,
      if (documentType != null) 'document_type': documentType,
      if (reminderDate != null) 'reminder_date': reminderDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodosCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? dueDate,
    Value<int>? isCompleted,
    Value<String>? type,
    Value<String?>? documentType,
    Value<String?>? reminderDate,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      documentType: documentType ?? this.documentType,
      reminderDate: reminderDate ?? this.reminderDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<int>(isCompleted.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (reminderDate.present) {
      map['reminder_date'] = Variable<String>(reminderDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('type: $type, ')
          ..write('documentType: $documentType, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Transactions extends Table with TableInfo<Transactions, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Transactions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  late final GeneratedColumn<int> isRecurring = GeneratedColumn<int>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (transaction_type IN (\'income\', \'expense\'))',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', \'now\') AS int))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', \'now\') AS int)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    amount,
    categoryId,
    note,
    isRecurring,
    transactionType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_recurring'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  Transactions createAlias(String alias) {
    return Transactions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final int date;
  final double amount;
  final String categoryId;
  final String? note;
  final int isRecurring;
  final String transactionType;
  final int createdAt;
  const TransactionRow({
    required this.id,
    required this.date,
    required this.amount,
    required this.categoryId,
    this.note,
    required this.isRecurring,
    required this.transactionType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<int>(date);
    map['amount'] = Variable<double>(amount);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_recurring'] = Variable<int>(isRecurring);
    map['transaction_type'] = Variable<String>(transactionType);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: Value(date),
      amount: Value(amount),
      categoryId: Value(categoryId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isRecurring: Value(isRecurring),
      transactionType: Value(transactionType),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<int>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<String>(json['category_id']),
      note: serializer.fromJson<String?>(json['note']),
      isRecurring: serializer.fromJson<int>(json['is_recurring']),
      transactionType: serializer.fromJson<String>(json['transaction_type']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<int>(date),
      'amount': serializer.toJson<double>(amount),
      'category_id': serializer.toJson<String>(categoryId),
      'note': serializer.toJson<String?>(note),
      'is_recurring': serializer.toJson<int>(isRecurring),
      'transaction_type': serializer.toJson<String>(transactionType),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  TransactionRow copyWith({
    String? id,
    int? date,
    double? amount,
    String? categoryId,
    Value<String?> note = const Value.absent(),
    int? isRecurring,
    String? transactionType,
    int? createdAt,
  }) => TransactionRow(
    id: id ?? this.id,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    categoryId: categoryId ?? this.categoryId,
    note: note.present ? note.value : this.note,
    isRecurring: isRecurring ?? this.isRecurring,
    transactionType: transactionType ?? this.transactionType,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      note: data.note.present ? data.note.value : this.note,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('transactionType: $transactionType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    amount,
    categoryId,
    note,
    isRecurring,
    transactionType,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.note == this.note &&
          other.isRecurring == this.isRecurring &&
          other.transactionType == this.transactionType &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<int> date;
  final Value<double> amount;
  final Value<String> categoryId;
  final Value<String?> note;
  final Value<int> isRecurring;
  final Value<String> transactionType;
  final Value<int> createdAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.note = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required int date,
    required double amount,
    required String categoryId,
    this.note = const Value.absent(),
    this.isRecurring = const Value.absent(),
    required String transactionType,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       amount = Value(amount),
       categoryId = Value(categoryId),
       transactionType = Value(transactionType);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<int>? date,
    Expression<double>? amount,
    Expression<String>? categoryId,
    Expression<String>? note,
    Expression<int>? isRecurring,
    Expression<String>? transactionType,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (note != null) 'note': note,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (transactionType != null) 'transaction_type': transactionType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<int>? date,
    Value<double>? amount,
    Value<String>? categoryId,
    Value<String?>? note,
    Value<int>? isRecurring,
    Value<String>? transactionType,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<int>(isRecurring.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('transactionType: $transactionType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Categories extends Table with TableInfo<Categories, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (type IN (\'income\', \'expense\'))',
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _colourMeta = const VerificationMeta('colour');
  late final GeneratedColumn<String> colour = GeneratedColumn<String>(
    'colour',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    iconName,
    colour,
    isDefault,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('colour')) {
      context.handle(
        _colourMeta,
        colour.isAcceptableOrUnknown(data['colour']!, _colourMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
      colour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colour'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_default'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      ),
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String type;
  final String? iconName;
  final String? colour;
  final int isDefault;
  final int? sortOrder;
  const Category({
    required this.id,
    required this.name,
    required this.type,
    this.iconName,
    this.colour,
    required this.isDefault,
    this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    if (!nullToAbsent || colour != null) {
      map['colour'] = Variable<String>(colour);
    }
    map['is_default'] = Variable<int>(isDefault);
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<int>(sortOrder);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      colour: colour == null && nullToAbsent
          ? const Value.absent()
          : Value(colour),
      isDefault: Value(isDefault),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      iconName: serializer.fromJson<String?>(json['icon_name']),
      colour: serializer.fromJson<String?>(json['colour']),
      isDefault: serializer.fromJson<int>(json['is_default']),
      sortOrder: serializer.fromJson<int?>(json['sort_order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'icon_name': serializer.toJson<String?>(iconName),
      'colour': serializer.toJson<String?>(colour),
      'is_default': serializer.toJson<int>(isDefault),
      'sort_order': serializer.toJson<int?>(sortOrder),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? type,
    Value<String?> iconName = const Value.absent(),
    Value<String?> colour = const Value.absent(),
    int? isDefault,
    Value<int?> sortOrder = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    iconName: iconName.present ? iconName.value : this.iconName,
    colour: colour.present ? colour.value : this.colour,
    isDefault: isDefault ?? this.isDefault,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      colour: data.colour.present ? data.colour.value : this.colour,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconName: $iconName, ')
          ..write('colour: $colour, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, iconName, colour, isDefault, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.iconName == this.iconName &&
          other.colour == this.colour &&
          other.isDefault == this.isDefault &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> iconName;
  final Value<String?> colour;
  final Value<int> isDefault;
  final Value<int?> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colour = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.iconName = const Value.absent(),
    this.colour = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? iconName,
    Expression<String>? colour,
    Expression<int>? isDefault,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (iconName != null) 'icon_name': iconName,
      if (colour != null) 'colour': colour,
      if (isDefault != null) 'is_default': isDefault,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? iconName,
    Value<String?>? colour,
    Value<int>? isDefault,
    Value<int?>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      iconName: iconName ?? this.iconName,
      colour: colour ?? this.colour,
      isDefault: isDefault ?? this.isDefault,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colour.present) {
      map['colour'] = Variable<String>(colour.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconName: $iconName, ')
          ..write('colour: $colour, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UserProfileTable extends Table
    with TableInfo<UserProfileTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY CHECK (id = 1)',
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'User\'',
    defaultValue: const CustomExpression('\'User\''),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'light\'',
    defaultValue: const CustomExpression('\'light\''),
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'zh\'',
    defaultValue: const CustomExpression('\'zh\''),
  );
  static const VerificationMeta _monthlySalaryMeta = const VerificationMeta(
    'monthlySalary',
  );
  late final GeneratedColumn<double> monthlySalary = GeneratedColumn<double>(
    'monthly_salary',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _salaryDayMeta = const VerificationMeta(
    'salaryDay',
  );
  late final GeneratedColumn<int> salaryDay = GeneratedColumn<int>(
    'salary_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (salary_day BETWEEN 1 AND 31)',
  );
  static const VerificationMeta _focusDurationMinutesMeta =
      const VerificationMeta('focusDurationMinutes');
  late final GeneratedColumn<int> focusDurationMinutes = GeneratedColumn<int>(
    'focus_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 25',
    defaultValue: const CustomExpression('25'),
  );
  static const VerificationMeta _breakDurationMinutesMeta =
      const VerificationMeta('breakDurationMinutes');
  late final GeneratedColumn<int> breakDurationMinutes = GeneratedColumn<int>(
    'break_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 5',
    defaultValue: const CustomExpression('5'),
  );
  static const VerificationMeta _preferredUnitMeta = const VerificationMeta(
    'preferredUnit',
  );
  late final GeneratedColumn<String> preferredUnit = GeneratedColumn<String>(
    'preferred_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'metric\'',
    defaultValue: const CustomExpression('\'metric\''),
  );
  static const VerificationMeta _accentColourMeta = const VerificationMeta(
    'accentColour',
  );
  late final GeneratedColumn<String> accentColour = GeneratedColumn<String>(
    'accent_colour',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'#DE2910\'',
    defaultValue: const CustomExpression('\'#DE2910\''),
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _healthSyncEnabledMeta = const VerificationMeta(
    'healthSyncEnabled',
  );
  late final GeneratedColumn<int> healthSyncEnabled = GeneratedColumn<int>(
    'health_sync_enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _rabbitEnabledMeta = const VerificationMeta(
    'rabbitEnabled',
  );
  late final GeneratedColumn<int> rabbitEnabled = GeneratedColumn<int>(
    'rabbit_enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    themeMode,
    locale,
    monthlySalary,
    salaryDay,
    focusDurationMinutes,
    breakDurationMinutes,
    preferredUnit,
    accentColour,
    heightCm,
    weightKg,
    healthSyncEnabled,
    rabbitEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('monthly_salary')) {
      context.handle(
        _monthlySalaryMeta,
        monthlySalary.isAcceptableOrUnknown(
          data['monthly_salary']!,
          _monthlySalaryMeta,
        ),
      );
    }
    if (data.containsKey('salary_day')) {
      context.handle(
        _salaryDayMeta,
        salaryDay.isAcceptableOrUnknown(data['salary_day']!, _salaryDayMeta),
      );
    }
    if (data.containsKey('focus_duration_minutes')) {
      context.handle(
        _focusDurationMinutesMeta,
        focusDurationMinutes.isAcceptableOrUnknown(
          data['focus_duration_minutes']!,
          _focusDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('break_duration_minutes')) {
      context.handle(
        _breakDurationMinutesMeta,
        breakDurationMinutes.isAcceptableOrUnknown(
          data['break_duration_minutes']!,
          _breakDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('preferred_unit')) {
      context.handle(
        _preferredUnitMeta,
        preferredUnit.isAcceptableOrUnknown(
          data['preferred_unit']!,
          _preferredUnitMeta,
        ),
      );
    }
    if (data.containsKey('accent_colour')) {
      context.handle(
        _accentColourMeta,
        accentColour.isAcceptableOrUnknown(
          data['accent_colour']!,
          _accentColourMeta,
        ),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('health_sync_enabled')) {
      context.handle(
        _healthSyncEnabledMeta,
        healthSyncEnabled.isAcceptableOrUnknown(
          data['health_sync_enabled']!,
          _healthSyncEnabledMeta,
        ),
      );
    }
    if (data.containsKey('rabbit_enabled')) {
      context.handle(
        _rabbitEnabledMeta,
        rabbitEnabled.isAcceptableOrUnknown(
          data['rabbit_enabled']!,
          _rabbitEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      monthlySalary: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_salary'],
      ),
      salaryDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary_day'],
      ),
      focusDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_duration_minutes'],
      )!,
      breakDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}break_duration_minutes'],
      )!,
      preferredUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_unit'],
      )!,
      accentColour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_colour'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      healthSyncEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}health_sync_enabled'],
      )!,
      rabbitEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rabbit_enabled'],
      )!,
    );
  }

  @override
  UserProfileTable createAlias(String alias) {
    return UserProfileTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String username;
  final String themeMode;
  final String locale;
  final double? monthlySalary;
  final int? salaryDay;
  final int focusDurationMinutes;
  final int breakDurationMinutes;
  final String preferredUnit;
  final String accentColour;
  final double? heightCm;
  final double? weightKg;
  final int healthSyncEnabled;
  final int rabbitEnabled;
  const UserProfile({
    required this.id,
    required this.username,
    required this.themeMode,
    required this.locale,
    this.monthlySalary,
    this.salaryDay,
    required this.focusDurationMinutes,
    required this.breakDurationMinutes,
    required this.preferredUnit,
    required this.accentColour,
    this.heightCm,
    this.weightKg,
    required this.healthSyncEnabled,
    required this.rabbitEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['theme_mode'] = Variable<String>(themeMode);
    map['locale'] = Variable<String>(locale);
    if (!nullToAbsent || monthlySalary != null) {
      map['monthly_salary'] = Variable<double>(monthlySalary);
    }
    if (!nullToAbsent || salaryDay != null) {
      map['salary_day'] = Variable<int>(salaryDay);
    }
    map['focus_duration_minutes'] = Variable<int>(focusDurationMinutes);
    map['break_duration_minutes'] = Variable<int>(breakDurationMinutes);
    map['preferred_unit'] = Variable<String>(preferredUnit);
    map['accent_colour'] = Variable<String>(accentColour);
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['health_sync_enabled'] = Variable<int>(healthSyncEnabled);
    map['rabbit_enabled'] = Variable<int>(rabbitEnabled);
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      id: Value(id),
      username: Value(username),
      themeMode: Value(themeMode),
      locale: Value(locale),
      monthlySalary: monthlySalary == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlySalary),
      salaryDay: salaryDay == null && nullToAbsent
          ? const Value.absent()
          : Value(salaryDay),
      focusDurationMinutes: Value(focusDurationMinutes),
      breakDurationMinutes: Value(breakDurationMinutes),
      preferredUnit: Value(preferredUnit),
      accentColour: Value(accentColour),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      healthSyncEnabled: Value(healthSyncEnabled),
      rabbitEnabled: Value(rabbitEnabled),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      themeMode: serializer.fromJson<String>(json['theme_mode']),
      locale: serializer.fromJson<String>(json['locale']),
      monthlySalary: serializer.fromJson<double?>(json['monthly_salary']),
      salaryDay: serializer.fromJson<int?>(json['salary_day']),
      focusDurationMinutes: serializer.fromJson<int>(
        json['focus_duration_minutes'],
      ),
      breakDurationMinutes: serializer.fromJson<int>(
        json['break_duration_minutes'],
      ),
      preferredUnit: serializer.fromJson<String>(json['preferred_unit']),
      accentColour: serializer.fromJson<String>(json['accent_colour']),
      heightCm: serializer.fromJson<double?>(json['height_cm']),
      weightKg: serializer.fromJson<double?>(json['weight_kg']),
      healthSyncEnabled: serializer.fromJson<int>(json['health_sync_enabled']),
      rabbitEnabled: serializer.fromJson<int>(json['rabbit_enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'theme_mode': serializer.toJson<String>(themeMode),
      'locale': serializer.toJson<String>(locale),
      'monthly_salary': serializer.toJson<double?>(monthlySalary),
      'salary_day': serializer.toJson<int?>(salaryDay),
      'focus_duration_minutes': serializer.toJson<int>(focusDurationMinutes),
      'break_duration_minutes': serializer.toJson<int>(breakDurationMinutes),
      'preferred_unit': serializer.toJson<String>(preferredUnit),
      'accent_colour': serializer.toJson<String>(accentColour),
      'height_cm': serializer.toJson<double?>(heightCm),
      'weight_kg': serializer.toJson<double?>(weightKg),
      'health_sync_enabled': serializer.toJson<int>(healthSyncEnabled),
      'rabbit_enabled': serializer.toJson<int>(rabbitEnabled),
    };
  }

  UserProfile copyWith({
    int? id,
    String? username,
    String? themeMode,
    String? locale,
    Value<double?> monthlySalary = const Value.absent(),
    Value<int?> salaryDay = const Value.absent(),
    int? focusDurationMinutes,
    int? breakDurationMinutes,
    String? preferredUnit,
    String? accentColour,
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    int? healthSyncEnabled,
    int? rabbitEnabled,
  }) => UserProfile(
    id: id ?? this.id,
    username: username ?? this.username,
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    monthlySalary: monthlySalary.present
        ? monthlySalary.value
        : this.monthlySalary,
    salaryDay: salaryDay.present ? salaryDay.value : this.salaryDay,
    focusDurationMinutes: focusDurationMinutes ?? this.focusDurationMinutes,
    breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
    preferredUnit: preferredUnit ?? this.preferredUnit,
    accentColour: accentColour ?? this.accentColour,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    healthSyncEnabled: healthSyncEnabled ?? this.healthSyncEnabled,
    rabbitEnabled: rabbitEnabled ?? this.rabbitEnabled,
  );
  UserProfile copyWithCompanion(UserProfileCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      locale: data.locale.present ? data.locale.value : this.locale,
      monthlySalary: data.monthlySalary.present
          ? data.monthlySalary.value
          : this.monthlySalary,
      salaryDay: data.salaryDay.present ? data.salaryDay.value : this.salaryDay,
      focusDurationMinutes: data.focusDurationMinutes.present
          ? data.focusDurationMinutes.value
          : this.focusDurationMinutes,
      breakDurationMinutes: data.breakDurationMinutes.present
          ? data.breakDurationMinutes.value
          : this.breakDurationMinutes,
      preferredUnit: data.preferredUnit.present
          ? data.preferredUnit.value
          : this.preferredUnit,
      accentColour: data.accentColour.present
          ? data.accentColour.value
          : this.accentColour,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      healthSyncEnabled: data.healthSyncEnabled.present
          ? data.healthSyncEnabled.value
          : this.healthSyncEnabled,
      rabbitEnabled: data.rabbitEnabled.present
          ? data.rabbitEnabled.value
          : this.rabbitEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('salaryDay: $salaryDay, ')
          ..write('focusDurationMinutes: $focusDurationMinutes, ')
          ..write('breakDurationMinutes: $breakDurationMinutes, ')
          ..write('preferredUnit: $preferredUnit, ')
          ..write('accentColour: $accentColour, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('healthSyncEnabled: $healthSyncEnabled, ')
          ..write('rabbitEnabled: $rabbitEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    themeMode,
    locale,
    monthlySalary,
    salaryDay,
    focusDurationMinutes,
    breakDurationMinutes,
    preferredUnit,
    accentColour,
    heightCm,
    weightKg,
    healthSyncEnabled,
    rabbitEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.username == this.username &&
          other.themeMode == this.themeMode &&
          other.locale == this.locale &&
          other.monthlySalary == this.monthlySalary &&
          other.salaryDay == this.salaryDay &&
          other.focusDurationMinutes == this.focusDurationMinutes &&
          other.breakDurationMinutes == this.breakDurationMinutes &&
          other.preferredUnit == this.preferredUnit &&
          other.accentColour == this.accentColour &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.healthSyncEnabled == this.healthSyncEnabled &&
          other.rabbitEnabled == this.rabbitEnabled);
}

class UserProfileCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> themeMode;
  final Value<String> locale;
  final Value<double?> monthlySalary;
  final Value<int?> salaryDay;
  final Value<int> focusDurationMinutes;
  final Value<int> breakDurationMinutes;
  final Value<String> preferredUnit;
  final Value<String> accentColour;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<int> healthSyncEnabled;
  final Value<int> rabbitEnabled;
  const UserProfileCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.monthlySalary = const Value.absent(),
    this.salaryDay = const Value.absent(),
    this.focusDurationMinutes = const Value.absent(),
    this.breakDurationMinutes = const Value.absent(),
    this.preferredUnit = const Value.absent(),
    this.accentColour = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.healthSyncEnabled = const Value.absent(),
    this.rabbitEnabled = const Value.absent(),
  });
  UserProfileCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.monthlySalary = const Value.absent(),
    this.salaryDay = const Value.absent(),
    this.focusDurationMinutes = const Value.absent(),
    this.breakDurationMinutes = const Value.absent(),
    this.preferredUnit = const Value.absent(),
    this.accentColour = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.healthSyncEnabled = const Value.absent(),
    this.rabbitEnabled = const Value.absent(),
  });
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? themeMode,
    Expression<String>? locale,
    Expression<double>? monthlySalary,
    Expression<int>? salaryDay,
    Expression<int>? focusDurationMinutes,
    Expression<int>? breakDurationMinutes,
    Expression<String>? preferredUnit,
    Expression<String>? accentColour,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<int>? healthSyncEnabled,
    Expression<int>? rabbitEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (themeMode != null) 'theme_mode': themeMode,
      if (locale != null) 'locale': locale,
      if (monthlySalary != null) 'monthly_salary': monthlySalary,
      if (salaryDay != null) 'salary_day': salaryDay,
      if (focusDurationMinutes != null)
        'focus_duration_minutes': focusDurationMinutes,
      if (breakDurationMinutes != null)
        'break_duration_minutes': breakDurationMinutes,
      if (preferredUnit != null) 'preferred_unit': preferredUnit,
      if (accentColour != null) 'accent_colour': accentColour,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (healthSyncEnabled != null) 'health_sync_enabled': healthSyncEnabled,
      if (rabbitEnabled != null) 'rabbit_enabled': rabbitEnabled,
    });
  }

  UserProfileCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? themeMode,
    Value<String>? locale,
    Value<double?>? monthlySalary,
    Value<int?>? salaryDay,
    Value<int>? focusDurationMinutes,
    Value<int>? breakDurationMinutes,
    Value<String>? preferredUnit,
    Value<String>? accentColour,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<int>? healthSyncEnabled,
    Value<int>? rabbitEnabled,
  }) {
    return UserProfileCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      salaryDay: salaryDay ?? this.salaryDay,
      focusDurationMinutes: focusDurationMinutes ?? this.focusDurationMinutes,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
      preferredUnit: preferredUnit ?? this.preferredUnit,
      accentColour: accentColour ?? this.accentColour,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      healthSyncEnabled: healthSyncEnabled ?? this.healthSyncEnabled,
      rabbitEnabled: rabbitEnabled ?? this.rabbitEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (monthlySalary.present) {
      map['monthly_salary'] = Variable<double>(monthlySalary.value);
    }
    if (salaryDay.present) {
      map['salary_day'] = Variable<int>(salaryDay.value);
    }
    if (focusDurationMinutes.present) {
      map['focus_duration_minutes'] = Variable<int>(focusDurationMinutes.value);
    }
    if (breakDurationMinutes.present) {
      map['break_duration_minutes'] = Variable<int>(breakDurationMinutes.value);
    }
    if (preferredUnit.present) {
      map['preferred_unit'] = Variable<String>(preferredUnit.value);
    }
    if (accentColour.present) {
      map['accent_colour'] = Variable<String>(accentColour.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (healthSyncEnabled.present) {
      map['health_sync_enabled'] = Variable<int>(healthSyncEnabled.value);
    }
    if (rabbitEnabled.present) {
      map['rabbit_enabled'] = Variable<int>(rabbitEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('salaryDay: $salaryDay, ')
          ..write('focusDurationMinutes: $focusDurationMinutes, ')
          ..write('breakDurationMinutes: $breakDurationMinutes, ')
          ..write('preferredUnit: $preferredUnit, ')
          ..write('accentColour: $accentColour, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('healthSyncEnabled: $healthSyncEnabled, ')
          ..write('rabbitEnabled: $rabbitEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final HealthSyncLogs healthSyncLogs = HealthSyncLogs(this);
  late final RabbitAchievements rabbitAchievements = RabbitAchievements(this);
  late final ExerciseRecords exerciseRecords = ExerciseRecords(this);
  late final DiaryEntries diaryEntries = DiaryEntries(this);
  late final Todos todos = Todos(this);
  late final Transactions transactions = Transactions(this);
  late final Categories categories = Categories(this);
  late final UserProfileTable userProfile = UserProfileTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    healthSyncLogs,
    rabbitAchievements,
    exerciseRecords,
    diaryEntries,
    todos,
    transactions,
    categories,
    userProfile,
  ];
}

typedef $HealthSyncLogsCreateCompanionBuilder =
    HealthSyncLogsCompanion Function({
      Value<int> id,
      required int syncTime,
      required String platform,
      required String syncType,
      required String status,
      Value<int?> recordsCount,
      Value<String?> errorMessage,
    });
typedef $HealthSyncLogsUpdateCompanionBuilder =
    HealthSyncLogsCompanion Function({
      Value<int> id,
      Value<int> syncTime,
      Value<String> platform,
      Value<String> syncType,
      Value<String> status,
      Value<int?> recordsCount,
      Value<String?> errorMessage,
    });

class $HealthSyncLogsFilterComposer
    extends Composer<_$AppDatabase, HealthSyncLogs> {
  $HealthSyncLogsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsCount => $composableBuilder(
    column: $table.recordsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $HealthSyncLogsOrderingComposer
    extends Composer<_$AppDatabase, HealthSyncLogs> {
  $HealthSyncLogsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsCount => $composableBuilder(
    column: $table.recordsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $HealthSyncLogsAnnotationComposer
    extends Composer<_$AppDatabase, HealthSyncLogs> {
  $HealthSyncLogsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get syncTime =>
      $composableBuilder(column: $table.syncTime, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get syncType =>
      $composableBuilder(column: $table.syncType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get recordsCount => $composableBuilder(
    column: $table.recordsCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $HealthSyncLogsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          HealthSyncLogs,
          HealthSyncLog,
          $HealthSyncLogsFilterComposer,
          $HealthSyncLogsOrderingComposer,
          $HealthSyncLogsAnnotationComposer,
          $HealthSyncLogsCreateCompanionBuilder,
          $HealthSyncLogsUpdateCompanionBuilder,
          (
            HealthSyncLog,
            BaseReferences<_$AppDatabase, HealthSyncLogs, HealthSyncLog>,
          ),
          HealthSyncLog,
          PrefetchHooks Function()
        > {
  $HealthSyncLogsTableManager(_$AppDatabase db, HealthSyncLogs table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $HealthSyncLogsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $HealthSyncLogsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $HealthSyncLogsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> syncTime = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<String> syncType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> recordsCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => HealthSyncLogsCompanion(
                id: id,
                syncTime: syncTime,
                platform: platform,
                syncType: syncType,
                status: status,
                recordsCount: recordsCount,
                errorMessage: errorMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int syncTime,
                required String platform,
                required String syncType,
                required String status,
                Value<int?> recordsCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => HealthSyncLogsCompanion.insert(
                id: id,
                syncTime: syncTime,
                platform: platform,
                syncType: syncType,
                status: status,
                recordsCount: recordsCount,
                errorMessage: errorMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $HealthSyncLogsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      HealthSyncLogs,
      HealthSyncLog,
      $HealthSyncLogsFilterComposer,
      $HealthSyncLogsOrderingComposer,
      $HealthSyncLogsAnnotationComposer,
      $HealthSyncLogsCreateCompanionBuilder,
      $HealthSyncLogsUpdateCompanionBuilder,
      (
        HealthSyncLog,
        BaseReferences<_$AppDatabase, HealthSyncLogs, HealthSyncLog>,
      ),
      HealthSyncLog,
      PrefetchHooks Function()
    >;
typedef $RabbitAchievementsCreateCompanionBuilder =
    RabbitAchievementsCompanion Function({
      required String id,
      required String type,
      required int achievedAt,
      Value<int> shownToUser,
      Value<int> rowid,
    });
typedef $RabbitAchievementsUpdateCompanionBuilder =
    RabbitAchievementsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<int> achievedAt,
      Value<int> shownToUser,
      Value<int> rowid,
    });

class $RabbitAchievementsFilterComposer
    extends Composer<_$AppDatabase, RabbitAchievements> {
  $RabbitAchievementsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shownToUser => $composableBuilder(
    column: $table.shownToUser,
    builder: (column) => ColumnFilters(column),
  );
}

class $RabbitAchievementsOrderingComposer
    extends Composer<_$AppDatabase, RabbitAchievements> {
  $RabbitAchievementsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shownToUser => $composableBuilder(
    column: $table.shownToUser,
    builder: (column) => ColumnOrderings(column),
  );
}

class $RabbitAchievementsAnnotationComposer
    extends Composer<_$AppDatabase, RabbitAchievements> {
  $RabbitAchievementsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shownToUser => $composableBuilder(
    column: $table.shownToUser,
    builder: (column) => column,
  );
}

class $RabbitAchievementsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          RabbitAchievements,
          RabbitAchievement,
          $RabbitAchievementsFilterComposer,
          $RabbitAchievementsOrderingComposer,
          $RabbitAchievementsAnnotationComposer,
          $RabbitAchievementsCreateCompanionBuilder,
          $RabbitAchievementsUpdateCompanionBuilder,
          (
            RabbitAchievement,
            BaseReferences<
              _$AppDatabase,
              RabbitAchievements,
              RabbitAchievement
            >,
          ),
          RabbitAchievement,
          PrefetchHooks Function()
        > {
  $RabbitAchievementsTableManager(_$AppDatabase db, RabbitAchievements table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RabbitAchievementsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RabbitAchievementsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RabbitAchievementsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> achievedAt = const Value.absent(),
                Value<int> shownToUser = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RabbitAchievementsCompanion(
                id: id,
                type: type,
                achievedAt: achievedAt,
                shownToUser: shownToUser,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required int achievedAt,
                Value<int> shownToUser = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RabbitAchievementsCompanion.insert(
                id: id,
                type: type,
                achievedAt: achievedAt,
                shownToUser: shownToUser,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $RabbitAchievementsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      RabbitAchievements,
      RabbitAchievement,
      $RabbitAchievementsFilterComposer,
      $RabbitAchievementsOrderingComposer,
      $RabbitAchievementsAnnotationComposer,
      $RabbitAchievementsCreateCompanionBuilder,
      $RabbitAchievementsUpdateCompanionBuilder,
      (
        RabbitAchievement,
        BaseReferences<_$AppDatabase, RabbitAchievements, RabbitAchievement>,
      ),
      RabbitAchievement,
      PrefetchHooks Function()
    >;
typedef $ExerciseRecordsCreateCompanionBuilder =
    ExerciseRecordsCompanion Function({
      required String id,
      required String type,
      Value<int?> startTime,
      Value<int?> durationSeconds,
      Value<double?> distanceKm,
      Value<String?> routeJson,
      Value<String?> encodedPolyline,
      Value<int?> steps,
      Value<double?> caloriesBurned,
      Value<double?> weightAtTimeKg,
      Value<int> syncedToHealth,
      Value<String?> healthPlatformId,
      Value<int> rowid,
    });
typedef $ExerciseRecordsUpdateCompanionBuilder =
    ExerciseRecordsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<int?> startTime,
      Value<int?> durationSeconds,
      Value<double?> distanceKm,
      Value<String?> routeJson,
      Value<String?> encodedPolyline,
      Value<int?> steps,
      Value<double?> caloriesBurned,
      Value<double?> weightAtTimeKg,
      Value<int> syncedToHealth,
      Value<String?> healthPlatformId,
      Value<int> rowid,
    });

class $ExerciseRecordsFilterComposer
    extends Composer<_$AppDatabase, ExerciseRecords> {
  $ExerciseRecordsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeJson => $composableBuilder(
    column: $table.routeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encodedPolyline => $composableBuilder(
    column: $table.encodedPolyline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightAtTimeKg => $composableBuilder(
    column: $table.weightAtTimeKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncedToHealth => $composableBuilder(
    column: $table.syncedToHealth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthPlatformId => $composableBuilder(
    column: $table.healthPlatformId,
    builder: (column) => ColumnFilters(column),
  );
}

class $ExerciseRecordsOrderingComposer
    extends Composer<_$AppDatabase, ExerciseRecords> {
  $ExerciseRecordsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeJson => $composableBuilder(
    column: $table.routeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encodedPolyline => $composableBuilder(
    column: $table.encodedPolyline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightAtTimeKg => $composableBuilder(
    column: $table.weightAtTimeKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncedToHealth => $composableBuilder(
    column: $table.syncedToHealth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthPlatformId => $composableBuilder(
    column: $table.healthPlatformId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ExerciseRecordsAnnotationComposer
    extends Composer<_$AppDatabase, ExerciseRecords> {
  $ExerciseRecordsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get routeJson =>
      $composableBuilder(column: $table.routeJson, builder: (column) => column);

  GeneratedColumn<String> get encodedPolyline => $composableBuilder(
    column: $table.encodedPolyline,
    builder: (column) => column,
  );

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightAtTimeKg => $composableBuilder(
    column: $table.weightAtTimeKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncedToHealth => $composableBuilder(
    column: $table.syncedToHealth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get healthPlatformId => $composableBuilder(
    column: $table.healthPlatformId,
    builder: (column) => column,
  );
}

class $ExerciseRecordsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          ExerciseRecords,
          ExerciseRecord,
          $ExerciseRecordsFilterComposer,
          $ExerciseRecordsOrderingComposer,
          $ExerciseRecordsAnnotationComposer,
          $ExerciseRecordsCreateCompanionBuilder,
          $ExerciseRecordsUpdateCompanionBuilder,
          (
            ExerciseRecord,
            BaseReferences<_$AppDatabase, ExerciseRecords, ExerciseRecord>,
          ),
          ExerciseRecord,
          PrefetchHooks Function()
        > {
  $ExerciseRecordsTableManager(_$AppDatabase db, ExerciseRecords table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ExerciseRecordsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ExerciseRecordsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ExerciseRecordsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> startTime = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<double?> distanceKm = const Value.absent(),
                Value<String?> routeJson = const Value.absent(),
                Value<String?> encodedPolyline = const Value.absent(),
                Value<int?> steps = const Value.absent(),
                Value<double?> caloriesBurned = const Value.absent(),
                Value<double?> weightAtTimeKg = const Value.absent(),
                Value<int> syncedToHealth = const Value.absent(),
                Value<String?> healthPlatformId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseRecordsCompanion(
                id: id,
                type: type,
                startTime: startTime,
                durationSeconds: durationSeconds,
                distanceKm: distanceKm,
                routeJson: routeJson,
                encodedPolyline: encodedPolyline,
                steps: steps,
                caloriesBurned: caloriesBurned,
                weightAtTimeKg: weightAtTimeKg,
                syncedToHealth: syncedToHealth,
                healthPlatformId: healthPlatformId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                Value<int?> startTime = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<double?> distanceKm = const Value.absent(),
                Value<String?> routeJson = const Value.absent(),
                Value<String?> encodedPolyline = const Value.absent(),
                Value<int?> steps = const Value.absent(),
                Value<double?> caloriesBurned = const Value.absent(),
                Value<double?> weightAtTimeKg = const Value.absent(),
                Value<int> syncedToHealth = const Value.absent(),
                Value<String?> healthPlatformId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseRecordsCompanion.insert(
                id: id,
                type: type,
                startTime: startTime,
                durationSeconds: durationSeconds,
                distanceKm: distanceKm,
                routeJson: routeJson,
                encodedPolyline: encodedPolyline,
                steps: steps,
                caloriesBurned: caloriesBurned,
                weightAtTimeKg: weightAtTimeKg,
                syncedToHealth: syncedToHealth,
                healthPlatformId: healthPlatformId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ExerciseRecordsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      ExerciseRecords,
      ExerciseRecord,
      $ExerciseRecordsFilterComposer,
      $ExerciseRecordsOrderingComposer,
      $ExerciseRecordsAnnotationComposer,
      $ExerciseRecordsCreateCompanionBuilder,
      $ExerciseRecordsUpdateCompanionBuilder,
      (
        ExerciseRecord,
        BaseReferences<_$AppDatabase, ExerciseRecords, ExerciseRecord>,
      ),
      ExerciseRecord,
      PrefetchHooks Function()
    >;
typedef $DiaryEntriesCreateCompanionBuilder =
    DiaryEntriesCompanion Function({
      required String id,
      required String date,
      Value<String?> content,
      Value<int?> mood,
      Value<String?> imagePaths,
      Value<String?> linkedEventId,
      Value<int> rowid,
    });
typedef $DiaryEntriesUpdateCompanionBuilder =
    DiaryEntriesCompanion Function({
      Value<String> id,
      Value<String> date,
      Value<String?> content,
      Value<int?> mood,
      Value<String?> imagePaths,
      Value<String?> linkedEventId,
      Value<int> rowid,
    });

class $DiaryEntriesFilterComposer
    extends Composer<_$AppDatabase, DiaryEntries> {
  $DiaryEntriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePaths => $composableBuilder(
    column: $table.imagePaths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedEventId => $composableBuilder(
    column: $table.linkedEventId,
    builder: (column) => ColumnFilters(column),
  );
}

class $DiaryEntriesOrderingComposer
    extends Composer<_$AppDatabase, DiaryEntries> {
  $DiaryEntriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePaths => $composableBuilder(
    column: $table.imagePaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedEventId => $composableBuilder(
    column: $table.linkedEventId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $DiaryEntriesAnnotationComposer
    extends Composer<_$AppDatabase, DiaryEntries> {
  $DiaryEntriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get imagePaths => $composableBuilder(
    column: $table.imagePaths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedEventId => $composableBuilder(
    column: $table.linkedEventId,
    builder: (column) => column,
  );
}

class $DiaryEntriesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          DiaryEntries,
          DiaryEntry,
          $DiaryEntriesFilterComposer,
          $DiaryEntriesOrderingComposer,
          $DiaryEntriesAnnotationComposer,
          $DiaryEntriesCreateCompanionBuilder,
          $DiaryEntriesUpdateCompanionBuilder,
          (DiaryEntry, BaseReferences<_$AppDatabase, DiaryEntries, DiaryEntry>),
          DiaryEntry,
          PrefetchHooks Function()
        > {
  $DiaryEntriesTableManager(_$AppDatabase db, DiaryEntries table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DiaryEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DiaryEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DiaryEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String?> imagePaths = const Value.absent(),
                Value<String?> linkedEventId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiaryEntriesCompanion(
                id: id,
                date: date,
                content: content,
                mood: mood,
                imagePaths: imagePaths,
                linkedEventId: linkedEventId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String date,
                Value<String?> content = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String?> imagePaths = const Value.absent(),
                Value<String?> linkedEventId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiaryEntriesCompanion.insert(
                id: id,
                date: date,
                content: content,
                mood: mood,
                imagePaths: imagePaths,
                linkedEventId: linkedEventId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DiaryEntriesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      DiaryEntries,
      DiaryEntry,
      $DiaryEntriesFilterComposer,
      $DiaryEntriesOrderingComposer,
      $DiaryEntriesAnnotationComposer,
      $DiaryEntriesCreateCompanionBuilder,
      $DiaryEntriesUpdateCompanionBuilder,
      (DiaryEntry, BaseReferences<_$AppDatabase, DiaryEntries, DiaryEntry>),
      DiaryEntry,
      PrefetchHooks Function()
    >;
typedef $TodosCreateCompanionBuilder =
    TodosCompanion Function({
      required String id,
      required String title,
      Value<String?> dueDate,
      Value<int> isCompleted,
      Value<String> type,
      Value<String?> documentType,
      Value<String?> reminderDate,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $TodosUpdateCompanionBuilder =
    TodosCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> dueDate,
      Value<int> isCompleted,
      Value<String> type,
      Value<String?> documentType,
      Value<String?> reminderDate,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $TodosFilterComposer extends Composer<_$AppDatabase, Todos> {
  $TodosFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $TodosOrderingComposer extends Composer<_$AppDatabase, Todos> {
  $TodosOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TodosAnnotationComposer extends Composer<_$AppDatabase, Todos> {
  $TodosAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $TodosTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Todos,
          TodoRow,
          $TodosFilterComposer,
          $TodosOrderingComposer,
          $TodosAnnotationComposer,
          $TodosCreateCompanionBuilder,
          $TodosUpdateCompanionBuilder,
          (TodoRow, BaseReferences<_$AppDatabase, Todos, TodoRow>),
          TodoRow,
          PrefetchHooks Function()
        > {
  $TodosTableManager(_$AppDatabase db, Todos table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TodosFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TodosOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TodosAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<int> isCompleted = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> documentType = const Value.absent(),
                Value<String?> reminderDate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion(
                id: id,
                title: title,
                dueDate: dueDate,
                isCompleted: isCompleted,
                type: type,
                documentType: documentType,
                reminderDate: reminderDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> dueDate = const Value.absent(),
                Value<int> isCompleted = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> documentType = const Value.absent(),
                Value<String?> reminderDate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion.insert(
                id: id,
                title: title,
                dueDate: dueDate,
                isCompleted: isCompleted,
                type: type,
                documentType: documentType,
                reminderDate: reminderDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TodosProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Todos,
      TodoRow,
      $TodosFilterComposer,
      $TodosOrderingComposer,
      $TodosAnnotationComposer,
      $TodosCreateCompanionBuilder,
      $TodosUpdateCompanionBuilder,
      (TodoRow, BaseReferences<_$AppDatabase, Todos, TodoRow>),
      TodoRow,
      PrefetchHooks Function()
    >;
typedef $TransactionsCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required int date,
      required double amount,
      required String categoryId,
      Value<String?> note,
      Value<int> isRecurring,
      required String transactionType,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $TransactionsUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<int> date,
      Value<double> amount,
      Value<String> categoryId,
      Value<String?> note,
      Value<int> isRecurring,
      Value<String> transactionType,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $TransactionsFilterComposer
    extends Composer<_$AppDatabase, Transactions> {
  $TransactionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $TransactionsOrderingComposer
    extends Composer<_$AppDatabase, Transactions> {
  $TransactionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TransactionsAnnotationComposer
    extends Composer<_$AppDatabase, Transactions> {
  $TransactionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $TransactionsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Transactions,
          TransactionRow,
          $TransactionsFilterComposer,
          $TransactionsOrderingComposer,
          $TransactionsAnnotationComposer,
          $TransactionsCreateCompanionBuilder,
          $TransactionsUpdateCompanionBuilder,
          (
            TransactionRow,
            BaseReferences<_$AppDatabase, Transactions, TransactionRow>,
          ),
          TransactionRow,
          PrefetchHooks Function()
        > {
  $TransactionsTableManager(_$AppDatabase db, Transactions table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TransactionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TransactionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TransactionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> isRecurring = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                date: date,
                amount: amount,
                categoryId: categoryId,
                note: note,
                isRecurring: isRecurring,
                transactionType: transactionType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int date,
                required double amount,
                required String categoryId,
                Value<String?> note = const Value.absent(),
                Value<int> isRecurring = const Value.absent(),
                required String transactionType,
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                date: date,
                amount: amount,
                categoryId: categoryId,
                note: note,
                isRecurring: isRecurring,
                transactionType: transactionType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TransactionsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Transactions,
      TransactionRow,
      $TransactionsFilterComposer,
      $TransactionsOrderingComposer,
      $TransactionsAnnotationComposer,
      $TransactionsCreateCompanionBuilder,
      $TransactionsUpdateCompanionBuilder,
      (
        TransactionRow,
        BaseReferences<_$AppDatabase, Transactions, TransactionRow>,
      ),
      TransactionRow,
      PrefetchHooks Function()
    >;
typedef $CategoriesCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<String?> iconName,
      Value<String?> colour,
      Value<int> isDefault,
      Value<int?> sortOrder,
      Value<int> rowid,
    });
typedef $CategoriesUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String?> iconName,
      Value<String?> colour,
      Value<int> isDefault,
      Value<int?> sortOrder,
      Value<int> rowid,
    });

class $CategoriesFilterComposer extends Composer<_$AppDatabase, Categories> {
  $CategoriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $CategoriesOrderingComposer extends Composer<_$AppDatabase, Categories> {
  $CategoriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CategoriesAnnotationComposer
    extends Composer<_$AppDatabase, Categories> {
  $CategoriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get colour =>
      $composableBuilder(column: $table.colour, builder: (column) => column);

  GeneratedColumn<int> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $CategoriesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Categories,
          Category,
          $CategoriesFilterComposer,
          $CategoriesOrderingComposer,
          $CategoriesAnnotationComposer,
          $CategoriesCreateCompanionBuilder,
          $CategoriesUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, Categories, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $CategoriesTableManager(_$AppDatabase db, Categories table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CategoriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CategoriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CategoriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
                Value<String?> colour = const Value.absent(),
                Value<int> isDefault = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                type: type,
                iconName: iconName,
                colour: colour,
                isDefault: isDefault,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<String?> iconName = const Value.absent(),
                Value<String?> colour = const Value.absent(),
                Value<int> isDefault = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                type: type,
                iconName: iconName,
                colour: colour,
                isDefault: isDefault,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $CategoriesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Categories,
      Category,
      $CategoriesFilterComposer,
      $CategoriesOrderingComposer,
      $CategoriesAnnotationComposer,
      $CategoriesCreateCompanionBuilder,
      $CategoriesUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, Categories, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $UserProfileTableCreateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> themeMode,
      Value<String> locale,
      Value<double?> monthlySalary,
      Value<int?> salaryDay,
      Value<int> focusDurationMinutes,
      Value<int> breakDurationMinutes,
      Value<String> preferredUnit,
      Value<String> accentColour,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<int> healthSyncEnabled,
      Value<int> rabbitEnabled,
    });
typedef $UserProfileTableUpdateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> themeMode,
      Value<String> locale,
      Value<double?> monthlySalary,
      Value<int?> salaryDay,
      Value<int> focusDurationMinutes,
      Value<int> breakDurationMinutes,
      Value<String> preferredUnit,
      Value<String> accentColour,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<int> healthSyncEnabled,
      Value<int> rabbitEnabled,
    });

class $UserProfileTableFilterComposer
    extends Composer<_$AppDatabase, UserProfileTable> {
  $UserProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get salaryDay => $composableBuilder(
    column: $table.salaryDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusDurationMinutes => $composableBuilder(
    column: $table.focusDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakDurationMinutes => $composableBuilder(
    column: $table.breakDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredUnit => $composableBuilder(
    column: $table.preferredUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentColour => $composableBuilder(
    column: $table.accentColour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get healthSyncEnabled => $composableBuilder(
    column: $table.healthSyncEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rabbitEnabled => $composableBuilder(
    column: $table.rabbitEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $UserProfileTableOrderingComposer
    extends Composer<_$AppDatabase, UserProfileTable> {
  $UserProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get salaryDay => $composableBuilder(
    column: $table.salaryDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusDurationMinutes => $composableBuilder(
    column: $table.focusDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakDurationMinutes => $composableBuilder(
    column: $table.breakDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredUnit => $composableBuilder(
    column: $table.preferredUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentColour => $composableBuilder(
    column: $table.accentColour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get healthSyncEnabled => $composableBuilder(
    column: $table.healthSyncEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rabbitEnabled => $composableBuilder(
    column: $table.rabbitEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $UserProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, UserProfileTable> {
  $UserProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get salaryDay =>
      $composableBuilder(column: $table.salaryDay, builder: (column) => column);

  GeneratedColumn<int> get focusDurationMinutes => $composableBuilder(
    column: $table.focusDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get breakDurationMinutes => $composableBuilder(
    column: $table.breakDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredUnit => $composableBuilder(
    column: $table.preferredUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accentColour => $composableBuilder(
    column: $table.accentColour,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get healthSyncEnabled => $composableBuilder(
    column: $table.healthSyncEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rabbitEnabled => $composableBuilder(
    column: $table.rabbitEnabled,
    builder: (column) => column,
  );
}

class $UserProfileTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          UserProfileTable,
          UserProfile,
          $UserProfileTableFilterComposer,
          $UserProfileTableOrderingComposer,
          $UserProfileTableAnnotationComposer,
          $UserProfileTableCreateCompanionBuilder,
          $UserProfileTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, UserProfileTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $UserProfileTableTableManager(_$AppDatabase db, UserProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<double?> monthlySalary = const Value.absent(),
                Value<int?> salaryDay = const Value.absent(),
                Value<int> focusDurationMinutes = const Value.absent(),
                Value<int> breakDurationMinutes = const Value.absent(),
                Value<String> preferredUnit = const Value.absent(),
                Value<String> accentColour = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int> healthSyncEnabled = const Value.absent(),
                Value<int> rabbitEnabled = const Value.absent(),
              }) => UserProfileCompanion(
                id: id,
                username: username,
                themeMode: themeMode,
                locale: locale,
                monthlySalary: monthlySalary,
                salaryDay: salaryDay,
                focusDurationMinutes: focusDurationMinutes,
                breakDurationMinutes: breakDurationMinutes,
                preferredUnit: preferredUnit,
                accentColour: accentColour,
                heightCm: heightCm,
                weightKg: weightKg,
                healthSyncEnabled: healthSyncEnabled,
                rabbitEnabled: rabbitEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<double?> monthlySalary = const Value.absent(),
                Value<int?> salaryDay = const Value.absent(),
                Value<int> focusDurationMinutes = const Value.absent(),
                Value<int> breakDurationMinutes = const Value.absent(),
                Value<String> preferredUnit = const Value.absent(),
                Value<String> accentColour = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int> healthSyncEnabled = const Value.absent(),
                Value<int> rabbitEnabled = const Value.absent(),
              }) => UserProfileCompanion.insert(
                id: id,
                username: username,
                themeMode: themeMode,
                locale: locale,
                monthlySalary: monthlySalary,
                salaryDay: salaryDay,
                focusDurationMinutes: focusDurationMinutes,
                breakDurationMinutes: breakDurationMinutes,
                preferredUnit: preferredUnit,
                accentColour: accentColour,
                heightCm: heightCm,
                weightKg: weightKg,
                healthSyncEnabled: healthSyncEnabled,
                rabbitEnabled: rabbitEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $UserProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      UserProfileTable,
      UserProfile,
      $UserProfileTableFilterComposer,
      $UserProfileTableOrderingComposer,
      $UserProfileTableAnnotationComposer,
      $UserProfileTableCreateCompanionBuilder,
      $UserProfileTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, UserProfileTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $HealthSyncLogsTableManager get healthSyncLogs =>
      $HealthSyncLogsTableManager(_db, _db.healthSyncLogs);
  $RabbitAchievementsTableManager get rabbitAchievements =>
      $RabbitAchievementsTableManager(_db, _db.rabbitAchievements);
  $ExerciseRecordsTableManager get exerciseRecords =>
      $ExerciseRecordsTableManager(_db, _db.exerciseRecords);
  $DiaryEntriesTableManager get diaryEntries =>
      $DiaryEntriesTableManager(_db, _db.diaryEntries);
  $TodosTableManager get todos => $TodosTableManager(_db, _db.todos);
  $TransactionsTableManager get transactions =>
      $TransactionsTableManager(_db, _db.transactions);
  $CategoriesTableManager get categories =>
      $CategoriesTableManager(_db, _db.categories);
  $UserProfileTableTableManager get userProfile =>
      $UserProfileTableTableManager(_db, _db.userProfile);
}
