import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});