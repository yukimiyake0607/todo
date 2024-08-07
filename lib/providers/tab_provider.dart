import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_provider.g.dart';

@riverpod
class tab extends _$tab {
  @override
  int build() {
    return 0;
  }

  void update(int index) {
    state = index;
  }
}
