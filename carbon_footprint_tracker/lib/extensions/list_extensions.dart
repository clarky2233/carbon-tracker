import 'package:carbon_footprint_tracker/extensions/map_extensions.dart';

extension ListExtension<T> on List<T> {
  T? mostCommon() {
    Map<T, int> freq = {};

    forEach((element) {
      freq.update(
        element,
        (value) => ++value,
        ifAbsent: () => 1,
      );
    });

    return freq.max();
  }
}
