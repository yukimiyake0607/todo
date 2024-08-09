// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hiveServiceHash() => r'8df37bcf610476ae55cb241c6cb79a2081550312';

/// See also [hiveService].
@ProviderFor(hiveService)
final hiveServiceProvider = AutoDisposeProvider<HiveService>.internal(
  hiveService,
  name: r'hiveServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hiveServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HiveServiceRef = AutoDisposeProviderRef<HiveService>;
String _$todoHash() => r'9faf7b6d43aab000b016a93643a3d61080824422';

/// See also [Todo].
@ProviderFor(Todo)
final todoProvider =
    AutoDisposeAsyncNotifierProvider<Todo, List<TodoModel>>.internal(
  Todo.new,
  name: r'todoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Todo = AutoDisposeAsyncNotifier<List<TodoModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
