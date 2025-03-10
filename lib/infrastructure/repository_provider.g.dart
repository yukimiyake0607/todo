// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'e2ce8c59ad17f827d2158935e144fd023e4b6e10';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = AutoDisposeProvider<ITodoRepository>.internal(
  todoRepository as ITodoRepository Function(
      AutoDisposeProviderRef<ITodoRepository> ref),
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoRepositoryRef = AutoDisposeProviderRef<ITodoRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
