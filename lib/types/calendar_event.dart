import 'calendar_event_item.dart';

class CalendarEvent {
  final String date;
  final List<CalendarEventItem> events;

  CalendarEvent({required this.date, required this.events});
}
