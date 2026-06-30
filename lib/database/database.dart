import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/clip_type.dart';

part 'database.g.dart';

class ClipboardItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get normalizedContent => text()();
  TextColumn get contentHash => text().withLength(min: 64, max: 64)(); // SHA256
  IntColumn get type => intEnum<ClipType>()();
  
  TextColumn get metadata => text().nullable()(); // JSON metadata (dimensions, file size, etc)
  TextColumn get ocrText => text().nullable()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastCopiedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get copyCount => integer().withDefault(const Constant(1))();
  
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  
  // Sync status
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get remoteId => text().nullable()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get colorValue => integer().nullable()();
}

class ItemTags extends Table {
  IntColumn get itemId => integer().references(ClipboardItems, #id)();
  IntColumn get tagId => integer().references(Tags, #id)();
  @override
  Set<Column> get primaryKey => {itemId, tagId};
}

class Collections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get parentId => integer().nullable().references(Collections, #id)();
}

class ItemCollections extends Table {
  IntColumn get itemId => integer().references(ClipboardItems, #id)();
  IntColumn get collectionId => integer().references(Collections, #id)();
  @override
  Set<Column> get primaryKey => {itemId, collectionId};
}

@DriftDatabase(tables: [ClipboardItems, Tags, ItemTags, Collections, ItemCollections])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'clipvault.sqlite'));
    return NativeDatabase(file);
  });
}
