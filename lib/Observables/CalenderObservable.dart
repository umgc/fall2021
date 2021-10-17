import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Utility/CalendarUtility.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/Observables/NoteObservable.dart';

part 'CalenderObservable.g.dart';

class CalendarObservable = _AbstractCalendarObserver with _$CalendarObservable;

abstract class _AbstractCalendarObserver with Store {
  @observable
  NoteObserver? noteObserver;

  @observable
  DateTime? selectedDay;

  @observable
  CalendarFormat calendarFormat = CalendarFormat.week;

  @observable
  ValueNotifier<List<Event>> selectedEvents = ValueNotifier([]);

  @action
  void changeFormat(CalendarFormat format) {
    calendarFormat = format;
  }

  @action
  void setNoteObserver(observer) {
    noteObserver = observer;
  }

  @action
  void setSelectedDay(DateTime day) {
    selectedDay = day;
  }

  @action
  List<Event> loadEventsOfSelectedDay(String day) {
    List<Event> eventsOnDay = [];
    for (TextNote note in noteObserver!.usersNotes) {
      print("note.eventDate: ${note.eventDate} SelectDay $day");
      if (note.eventDate == day) {
        eventsOnDay.add(Event(note.text));
      }
    }
    selectedEvents.value = eventsOnDay;
    return eventsOnDay;
  }
}
