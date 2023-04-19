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