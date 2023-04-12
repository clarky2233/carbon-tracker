class TMDFeatures {
  final double accelerometerMin;
  final double accelerometerMax;
  final double accelerometerMean;
  final double accelerometerStd;
  final double gyroscopeMin;
  final double gyroscopeMax;
  final double gyroscopeMean;
  final double gyroscopeStd;
  final double magnetometerMin;
  final double magnetometerMax;
  final double magnetometerMean;
  final double magnetometerStd;

  const TMDFeatures({
    this.accelerometerMin = 0,
    this.accelerometerMax = 0,
    this.accelerometerMean = 0,
    this.accelerometerStd = 0,
    this.gyroscopeMin = 0,
    this.gyroscopeMax = 0,
    this.gyroscopeMean = 0,
    this.gyroscopeStd = 0,
    this.magnetometerMin = 0,
    this.magnetometerMax = 0,
    this.magnetometerMean = 0,
    this.magnetometerStd = 0,
  });
}
