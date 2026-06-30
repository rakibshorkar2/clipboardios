// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'68c9ad772c198d1a34d2dcccc0a6a35f43092fd5';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppDatabaseRef = AutoDisposeProviderRef<AppDatabase>;
String _$clipboardServiceHash() => r'b1384973cfa62c8771e3301789a286ba33937b05';

/// See also [ClipboardService].
@ProviderFor(ClipboardService)
final clipboardServiceProvider =
    AutoDisposeNotifierProvider<ClipboardService, void>.internal(
  ClipboardService.new,
  name: r'clipboardServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clipboardServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClipboardService = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
