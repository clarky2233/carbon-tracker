import 'dart:async';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension MapExtension<T> on Map<T, int> {
  T? max() {
    int maxValue = 0;
    T? maxKey;

    forEach((key, value) {
      if (value > maxValue) {
        maxValue = value;
        maxKey = key;
      }
    });

    return maxKey;
  }
}

extension StreamExtension<T> on Stream<T> {
  Stream<List<T>> window(Duration duration) {
    List<T> buffer = [];
    DateTime startTime = DateTime.now();

    final transformer = StreamTransformer<T, List<T>>.fromHandlers(
      handleData: (data, EventSink<List<T>> sink) {
        if (buffer.isEmpty) {
          startTime = DateTime.now();
          buffer.add(data);
          return;
        }

        int runningTime = DateTime.now().difference(startTime).inMilliseconds;

        if (runningTime < duration.inMilliseconds) {
          buffer.add(data);
          return;
        }

        if (runningTime >= duration.inMilliseconds) {
          sink.add(buffer);
          buffer.clear();
          return;
        }
      },
    );

    return transform(transformer);
  }
}
