import 'dart:async';

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
