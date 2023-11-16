import 'package:flutter_riverpod/flutter_riverpod.dart';

final chartTimePeriodProvider = StateProvider<String>((ref) {
  return "All time";
});
