class TMDFeatures {
  final double accelerometerMin;
  final double accelerometerMax;
  final double accelerometerMean;
  final double accelerometerStd;
  final double gyroscopeMin;
  final double gyroscopeMax;
  final double gyroscopeMean;
  final double gyroscopeStd;

  const TMDFeatures({
    this.accelerometerMin = 0,
    this.accelerometerMax = 0,
    this.accelerometerMean = 0,
    this.accelerometerStd = 0,
    this.gyroscopeMin = 0,
    this.gyroscopeMax = 0,
    this.gyroscopeMean = 0,
    this.gyroscopeStd = 0,
  });

  @override
  String toString() {
    return 'TMDFeatures{accelerometerMin: $accelerometerMin, accelerometerMax: $accelerometerMax, accelerometerMean: $accelerometerMean, accelerometerStd: $accelerometerStd, gyroscopeMin: $gyroscopeMin, gyroscopeMax: $gyroscopeMax, gyroscopeMean: $gyroscopeMean, gyroscopeStd: $gyroscopeStd}';
  }
}
