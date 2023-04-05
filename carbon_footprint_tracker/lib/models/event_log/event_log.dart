import 'package:objectbox/objectbox.dart';

@Entity()
class EventLog {
  @Id()
  int id;

  @Property(type: PropertyType.date)
  DateTime dateTime;

  String event;

  EventLog({
    this.id = 0,
    required this.dateTime,
    required this.event,
  });
}
