abstract class TrackerEvent {
  abstract final String name;
  final DateTime receivedAt;

  TrackerEvent({DateTime? receivedAt})
      : receivedAt = receivedAt ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerEvent &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
