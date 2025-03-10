import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/infrastructure/todo_repository_impl.dart';

part 'repository_provider.g.dart';

@riverpod
class ITodoRepository extends _$ITodoRepository {
  @override
   build() {
    return FirebaseTodoRepository();
  }
}