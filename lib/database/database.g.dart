// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClipboardItemsTable extends ClipboardItems
    with TableInfo<$ClipboardItemsTable, ClipboardItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClipboardItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _normalizedContentMeta =
      const VerificationMeta('normalizedContent');
  @override
  late final GeneratedColumn<String> normalizedContent =
      GeneratedColumn<String>('normalized_content', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentHashMeta =
      const VerificationMeta('contentHash');
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
      'content_hash', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 64, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ClipType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ClipType>($ClipboardItemsTable.$convertertype);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ocrTextMeta =
      const VerificationMeta('ocrText');
  @override
  late final GeneratedColumn<String> ocrText = GeneratedColumn<String>(
      'ocr_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastCopiedAtMeta =
      const VerificationMeta('lastCopiedAt');
  @override
  late final GeneratedColumn<DateTime> lastCopiedAt = GeneratedColumn<DateTime>(
      'last_copied_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _copyCountMeta =
      const VerificationMeta('copyCount');
  @override
  late final GeneratedColumn<int> copyCount = GeneratedColumn<int>(
      'copy_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        normalizedContent,
        contentHash,
        type,
        metadata,
        ocrText,
        createdAt,
        updatedAt,
        lastCopiedAt,
        copyCount,
        isFavorite,
        isPinned,
        note,
        isSynced,
        remoteId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clipboard_items';
  @override
  VerificationContext validateIntegrity(Insertable<ClipboardItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('normalized_content')) {
      context.handle(
          _normalizedContentMeta,
          normalizedContent.isAcceptableOrUnknown(
              data['normalized_content']!, _normalizedContentMeta));
    } else if (isInserting) {
      context.missing(_normalizedContentMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
          _contentHashMeta,
          contentHash.isAcceptableOrUnknown(
              data['content_hash']!, _contentHashMeta));
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('ocr_text')) {
      context.handle(_ocrTextMeta,
          ocrText.isAcceptableOrUnknown(data['ocr_text']!, _ocrTextMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_copied_at')) {
      context.handle(
          _lastCopiedAtMeta,
          lastCopiedAt.isAcceptableOrUnknown(
              data['last_copied_at']!, _lastCopiedAtMeta));
    }
    if (data.containsKey('copy_count')) {
      context.handle(_copyCountMeta,
          copyCount.isAcceptableOrUnknown(data['copy_count']!, _copyCountMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClipboardItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClipboardItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      normalizedContent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}normalized_content'])!,
      contentHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_hash'])!,
      type: $ClipboardItemsTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata']),
      ocrText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ocr_text']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastCopiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_copied_at'])!,
      copyCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}copy_count'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
    );
  }

  @override
  $ClipboardItemsTable createAlias(String alias) {
    return $ClipboardItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ClipType, int, int> $convertertype =
      const EnumIndexConverter<ClipType>(ClipType.values);
}

class ClipboardItem extends DataClass implements Insertable<ClipboardItem> {
  final int id;
  final String content;
  final String normalizedContent;
  final String contentHash;
  final ClipType type;
  final String? metadata;
  final String? ocrText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastCopiedAt;
  final int copyCount;
  final bool isFavorite;
  final bool isPinned;
  final String? note;
  final bool isSynced;
  final String? remoteId;
  const ClipboardItem(
      {required this.id,
      required this.content,
      required this.normalizedContent,
      required this.contentHash,
      required this.type,
      this.metadata,
      this.ocrText,
      required this.createdAt,
      required this.updatedAt,
      required this.lastCopiedAt,
      required this.copyCount,
      required this.isFavorite,
      required this.isPinned,
      this.note,
      required this.isSynced,
      this.remoteId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['normalized_content'] = Variable<String>(normalizedContent);
    map['content_hash'] = Variable<String>(contentHash);
    {
      map['type'] =
          Variable<int>($ClipboardItemsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    if (!nullToAbsent || ocrText != null) {
      map['ocr_text'] = Variable<String>(ocrText);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['last_copied_at'] = Variable<DateTime>(lastCopiedAt);
    map['copy_count'] = Variable<int>(copyCount);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_pinned'] = Variable<bool>(isPinned);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  ClipboardItemsCompanion toCompanion(bool nullToAbsent) {
    return ClipboardItemsCompanion(
      id: Value(id),
      content: Value(content),
      normalizedContent: Value(normalizedContent),
      contentHash: Value(contentHash),
      type: Value(type),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      ocrText: ocrText == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastCopiedAt: Value(lastCopiedAt),
      copyCount: Value(copyCount),
      isFavorite: Value(isFavorite),
      isPinned: Value(isPinned),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isSynced: Value(isSynced),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory ClipboardItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClipboardItem(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      normalizedContent: serializer.fromJson<String>(json['normalizedContent']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      type: $ClipboardItemsTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      metadata: serializer.fromJson<String?>(json['metadata']),
      ocrText: serializer.fromJson<String?>(json['ocrText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastCopiedAt: serializer.fromJson<DateTime>(json['lastCopiedAt']),
      copyCount: serializer.fromJson<int>(json['copyCount']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      note: serializer.fromJson<String?>(json['note']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'normalizedContent': serializer.toJson<String>(normalizedContent),
      'contentHash': serializer.toJson<String>(contentHash),
      'type': serializer
          .toJson<int>($ClipboardItemsTable.$convertertype.toJson(type)),
      'metadata': serializer.toJson<String?>(metadata),
      'ocrText': serializer.toJson<String?>(ocrText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastCopiedAt': serializer.toJson<DateTime>(lastCopiedAt),
      'copyCount': serializer.toJson<int>(copyCount),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isPinned': serializer.toJson<bool>(isPinned),
      'note': serializer.toJson<String?>(note),
      'isSynced': serializer.toJson<bool>(isSynced),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  ClipboardItem copyWith(
          {int? id,
          String? content,
          String? normalizedContent,
          String? contentHash,
          ClipType? type,
          Value<String?> metadata = const Value.absent(),
          Value<String?> ocrText = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          DateTime? lastCopiedAt,
          int? copyCount,
          bool? isFavorite,
          bool? isPinned,
          Value<String?> note = const Value.absent(),
          bool? isSynced,
          Value<String?> remoteId = const Value.absent()}) =>
      ClipboardItem(
        id: id ?? this.id,
        content: content ?? this.content,
        normalizedContent: normalizedContent ?? this.normalizedContent,
        contentHash: contentHash ?? this.contentHash,
        type: type ?? this.type,
        metadata: metadata.present ? metadata.value : this.metadata,
        ocrText: ocrText.present ? ocrText.value : this.ocrText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastCopiedAt: lastCopiedAt ?? this.lastCopiedAt,
        copyCount: copyCount ?? this.copyCount,
        isFavorite: isFavorite ?? this.isFavorite,
        isPinned: isPinned ?? this.isPinned,
        note: note.present ? note.value : this.note,
        isSynced: isSynced ?? this.isSynced,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
      );
  ClipboardItem copyWithCompanion(ClipboardItemsCompanion data) {
    return ClipboardItem(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      normalizedContent: data.normalizedContent.present
          ? data.normalizedContent.value
          : this.normalizedContent,
      contentHash:
          data.contentHash.present ? data.contentHash.value : this.contentHash,
      type: data.type.present ? data.type.value : this.type,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      ocrText: data.ocrText.present ? data.ocrText.value : this.ocrText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastCopiedAt: data.lastCopiedAt.present
          ? data.lastCopiedAt.value
          : this.lastCopiedAt,
      copyCount: data.copyCount.present ? data.copyCount.value : this.copyCount,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      note: data.note.present ? data.note.value : this.note,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClipboardItem(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('normalizedContent: $normalizedContent, ')
          ..write('contentHash: $contentHash, ')
          ..write('type: $type, ')
          ..write('metadata: $metadata, ')
          ..write('ocrText: $ocrText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastCopiedAt: $lastCopiedAt, ')
          ..write('copyCount: $copyCount, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isPinned: $isPinned, ')
          ..write('note: $note, ')
          ..write('isSynced: $isSynced, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      content,
      normalizedContent,
      contentHash,
      type,
      metadata,
      ocrText,
      createdAt,
      updatedAt,
      lastCopiedAt,
      copyCount,
      isFavorite,
      isPinned,
      note,
      isSynced,
      remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClipboardItem &&
          other.id == this.id &&
          other.content == this.content &&
          other.normalizedContent == this.normalizedContent &&
          other.contentHash == this.contentHash &&
          other.type == this.type &&
          other.metadata == this.metadata &&
          other.ocrText == this.ocrText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastCopiedAt == this.lastCopiedAt &&
          other.copyCount == this.copyCount &&
          other.isFavorite == this.isFavorite &&
          other.isPinned == this.isPinned &&
          other.note == this.note &&
          other.isSynced == this.isSynced &&
          other.remoteId == this.remoteId);
}

class ClipboardItemsCompanion extends UpdateCompanion<ClipboardItem> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> normalizedContent;
  final Value<String> contentHash;
  final Value<ClipType> type;
  final Value<String?> metadata;
  final Value<String?> ocrText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime> lastCopiedAt;
  final Value<int> copyCount;
  final Value<bool> isFavorite;
  final Value<bool> isPinned;
  final Value<String?> note;
  final Value<bool> isSynced;
  final Value<String?> remoteId;
  const ClipboardItemsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.normalizedContent = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.type = const Value.absent(),
    this.metadata = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastCopiedAt = const Value.absent(),
    this.copyCount = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.note = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  ClipboardItemsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String normalizedContent,
    required String contentHash,
    required ClipType type,
    this.metadata = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastCopiedAt = const Value.absent(),
    this.copyCount = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.note = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.remoteId = const Value.absent(),
  })  : content = Value(content),
        normalizedContent = Value(normalizedContent),
        contentHash = Value(contentHash),
        type = Value(type);
  static Insertable<ClipboardItem> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? normalizedContent,
    Expression<String>? contentHash,
    Expression<int>? type,
    Expression<String>? metadata,
    Expression<String>? ocrText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastCopiedAt,
    Expression<int>? copyCount,
    Expression<bool>? isFavorite,
    Expression<bool>? isPinned,
    Expression<String>? note,
    Expression<bool>? isSynced,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (normalizedContent != null) 'normalized_content': normalizedContent,
      if (contentHash != null) 'content_hash': contentHash,
      if (type != null) 'type': type,
      if (metadata != null) 'metadata': metadata,
      if (ocrText != null) 'ocr_text': ocrText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastCopiedAt != null) 'last_copied_at': lastCopiedAt,
      if (copyCount != null) 'copy_count': copyCount,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isPinned != null) 'is_pinned': isPinned,
      if (note != null) 'note': note,
      if (isSynced != null) 'is_synced': isSynced,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  ClipboardItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<String>? normalizedContent,
      Value<String>? contentHash,
      Value<ClipType>? type,
      Value<String?>? metadata,
      Value<String?>? ocrText,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime>? lastCopiedAt,
      Value<int>? copyCount,
      Value<bool>? isFavorite,
      Value<bool>? isPinned,
      Value<String?>? note,
      Value<bool>? isSynced,
      Value<String?>? remoteId}) {
    return ClipboardItemsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      normalizedContent: normalizedContent ?? this.normalizedContent,
      contentHash: contentHash ?? this.contentHash,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
      ocrText: ocrText ?? this.ocrText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastCopiedAt: lastCopiedAt ?? this.lastCopiedAt,
      copyCount: copyCount ?? this.copyCount,
      isFavorite: isFavorite ?? this.isFavorite,
      isPinned: isPinned ?? this.isPinned,
      note: note ?? this.note,
      isSynced: isSynced ?? this.isSynced,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (normalizedContent.present) {
      map['normalized_content'] = Variable<String>(normalizedContent.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($ClipboardItemsTable.$convertertype.toSql(type.value));
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (ocrText.present) {
      map['ocr_text'] = Variable<String>(ocrText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastCopiedAt.present) {
      map['last_copied_at'] = Variable<DateTime>(lastCopiedAt.value);
    }
    if (copyCount.present) {
      map['copy_count'] = Variable<int>(copyCount.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClipboardItemsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('normalizedContent: $normalizedContent, ')
          ..write('contentHash: $contentHash, ')
          ..write('type: $type, ')
          ..write('metadata: $metadata, ')
          ..write('ocrText: $ocrText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastCopiedAt: $lastCopiedAt, ')
          ..write('copyCount: $copyCount, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isPinned: $isPinned, ')
          ..write('note: $note, ')
          ..write('isSynced: $isSynced, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, colorValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value']),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final int? colorValue;
  const Tag({required this.id, required this.name, this.colorValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int?>(colorValue),
    };
  }

  Tag copyWith(
          {int? id,
          String? name,
          Value<int?> colorValue = const Value.absent()}) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        colorValue: colorValue.present ? colorValue.value : this.colorValue,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> colorValue;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.colorValue = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int?>? colorValue}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, Collection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES collections (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, parentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(Insertable<Collection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Collection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Collection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class Collection extends DataClass implements Insertable<Collection> {
  final int id;
  final String name;
  final int? parentId;
  const Collection({required this.id, required this.name, this.parentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      id: Value(id),
      name: Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
    );
  }

  factory Collection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Collection(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<int?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<int?>(parentId),
    };
  }

  Collection copyWith(
          {int? id,
          String? name,
          Value<int?> parentId = const Value.absent()}) =>
      Collection(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId.present ? parentId.value : this.parentId,
      );
  Collection copyWithCompanion(CollectionsCompanion data) {
    return Collection(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Collection(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Collection &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentId == this.parentId);
}

class CollectionsCompanion extends UpdateCompanion<Collection> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> parentId;
  const CollectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
  });
  CollectionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.parentId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Collection> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? parentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
    });
  }

  CollectionsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int?>? parentId}) {
    return CollectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClipboardItemsTable clipboardItems = $ClipboardItemsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [clipboardItems, tags, collections];
}

typedef $$ClipboardItemsTableCreateCompanionBuilder = ClipboardItemsCompanion
    Function({
  Value<int> id,
  required String content,
  required String normalizedContent,
  required String contentHash,
  required ClipType type,
  Value<String?> metadata,
  Value<String?> ocrText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime> lastCopiedAt,
  Value<int> copyCount,
  Value<bool> isFavorite,
  Value<bool> isPinned,
  Value<String?> note,
  Value<bool> isSynced,
  Value<String?> remoteId,
});
typedef $$ClipboardItemsTableUpdateCompanionBuilder = ClipboardItemsCompanion
    Function({
  Value<int> id,
  Value<String> content,
  Value<String> normalizedContent,
  Value<String> contentHash,
  Value<ClipType> type,
  Value<String?> metadata,
  Value<String?> ocrText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime> lastCopiedAt,
  Value<int> copyCount,
  Value<bool> isFavorite,
  Value<bool> isPinned,
  Value<String?> note,
  Value<bool> isSynced,
  Value<String?> remoteId,
});

class $$ClipboardItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClipboardItemsTable,
    ClipboardItem,
    $$ClipboardItemsTableFilterComposer,
    $$ClipboardItemsTableOrderingComposer,
    $$ClipboardItemsTableCreateCompanionBuilder,
    $$ClipboardItemsTableUpdateCompanionBuilder> {
  $$ClipboardItemsTableTableManager(
      _$AppDatabase db, $ClipboardItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ClipboardItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ClipboardItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> normalizedContent = const Value.absent(),
            Value<String> contentHash = const Value.absent(),
            Value<ClipType> type = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<String?> ocrText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime> lastCopiedAt = const Value.absent(),
            Value<int> copyCount = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
          }) =>
              ClipboardItemsCompanion(
            id: id,
            content: content,
            normalizedContent: normalizedContent,
            contentHash: contentHash,
            type: type,
            metadata: metadata,
            ocrText: ocrText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastCopiedAt: lastCopiedAt,
            copyCount: copyCount,
            isFavorite: isFavorite,
            isPinned: isPinned,
            note: note,
            isSynced: isSynced,
            remoteId: remoteId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String content,
            required String normalizedContent,
            required String contentHash,
            required ClipType type,
            Value<String?> metadata = const Value.absent(),
            Value<String?> ocrText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime> lastCopiedAt = const Value.absent(),
            Value<int> copyCount = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
          }) =>
              ClipboardItemsCompanion.insert(
            id: id,
            content: content,
            normalizedContent: normalizedContent,
            contentHash: contentHash,
            type: type,
            metadata: metadata,
            ocrText: ocrText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastCopiedAt: lastCopiedAt,
            copyCount: copyCount,
            isFavorite: isFavorite,
            isPinned: isPinned,
            note: note,
            isSynced: isSynced,
            remoteId: remoteId,
          ),
        ));
}

class $$ClipboardItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ClipboardItemsTable> {
  $$ClipboardItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get normalizedContent => $state.composableBuilder(
      column: $state.table.normalizedContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get contentHash => $state.composableBuilder(
      column: $state.table.contentHash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ClipType, ClipType, int> get type =>
      $state.composableBuilder(
          column: $state.table.type,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get metadata => $state.composableBuilder(
      column: $state.table.metadata,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get ocrText => $state.composableBuilder(
      column: $state.table.ocrText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastCopiedAt => $state.composableBuilder(
      column: $state.table.lastCopiedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get copyCount => $state.composableBuilder(
      column: $state.table.copyCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPinned => $state.composableBuilder(
      column: $state.table.isPinned,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isSynced => $state.composableBuilder(
      column: $state.table.isSynced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get remoteId => $state.composableBuilder(
      column: $state.table.remoteId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ClipboardItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ClipboardItemsTable> {
  $$ClipboardItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get normalizedContent => $state.composableBuilder(
      column: $state.table.normalizedContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get contentHash => $state.composableBuilder(
      column: $state.table.contentHash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get metadata => $state.composableBuilder(
      column: $state.table.metadata,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get ocrText => $state.composableBuilder(
      column: $state.table.ocrText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastCopiedAt => $state.composableBuilder(
      column: $state.table.lastCopiedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get copyCount => $state.composableBuilder(
      column: $state.table.copyCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPinned => $state.composableBuilder(
      column: $state.table.isPinned,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isSynced => $state.composableBuilder(
      column: $state.table.isSynced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get remoteId => $state.composableBuilder(
      column: $state.table.remoteId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String name,
  Value<int?> colorValue,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int?> colorValue,
});

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> colorValue = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            name: name,
            colorValue: colorValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int?> colorValue = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            name: name,
            colorValue: colorValue,
          ),
        ));
}

class $$TagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CollectionsTableCreateCompanionBuilder = CollectionsCompanion
    Function({
  Value<int> id,
  required String name,
  Value<int?> parentId,
});
typedef $$CollectionsTableUpdateCompanionBuilder = CollectionsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int?> parentId,
});

class $$CollectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectionsTable,
    Collection,
    $$CollectionsTableFilterComposer,
    $$CollectionsTableOrderingComposer,
    $$CollectionsTableCreateCompanionBuilder,
    $$CollectionsTableUpdateCompanionBuilder> {
  $$CollectionsTableTableManager(_$AppDatabase db, $CollectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CollectionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CollectionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
          }) =>
              CollectionsCompanion(
            id: id,
            name: name,
            parentId: parentId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int?> parentId = const Value.absent(),
          }) =>
              CollectionsCompanion.insert(
            id: id,
            name: name,
            parentId: parentId,
          ),
        ));
}

class $$CollectionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CollectionsTableFilterComposer get parentId {
    final $$CollectionsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $state.db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CollectionsTableFilterComposer(ComposerState($state.db,
                $state.db.collections, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CollectionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CollectionsTableOrderingComposer get parentId {
    final $$CollectionsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $state.db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CollectionsTableOrderingComposer(ComposerState($state.db,
                $state.db.collections, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClipboardItemsTableTableManager get clipboardItems =>
      $$ClipboardItemsTableTableManager(_db, _db.clipboardItems);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
}
