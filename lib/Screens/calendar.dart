import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Observables/CalenderObservable.dart';
import 'package:untitled3/Utility/CalendarUtility.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  List<Event> _getEventsForDay(DateTime day) {
    return [
      Event("Gold"),
      Event("Alum"),
      Event("Platinum"),
      Event("Silver"),
      Event("Silk"),
      Event("Milk"),
      Event("Silver"),
      Event("Example"),
      Event("Good"),
      Event("Gold")
    ];
  }

  @override
  void dispose() {
    //_selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    final calendarObserver = Provider.of<CalendarObservable>(context);
    calendarObserver.setNoteObserver(noteObserver);
    return Observer(
        builder: (_) => Column(children: [
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.parse(
                    "2012-02-27"), //Date of the oldest past event
                lastDay: DateTime.parse("2022-02-27"), //Date of the last event
                calendarFormat:
                    CalendarFormat.week, //calendarObserver.calendarFormat,
                eventLoader: _getEventsForDay,
                onFormatChanged: (format) {
                  print("onFormatChanged: changing format to $format");
                  calendarObserver.changeFormat(format);
                },
                onDaySelected: (selectedDay, focusDay) {
                  print("onDaySelected: Day selected ${selectedDay.day}");
                  //exctract the date portion
                  String date = selectedDay.toString().split(" ")[0];
                  calendarObserver.loadEventsOfSelectedDay(date);
                },
                onPageChanged: (focusedDay) {
                  print("onPageChanged: Day selected $focusedDay");
                },
              ),
              ElevatedButton(
                child: Text('Clear selection'),
                onPressed: () {},
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                    valueListenable: calendarObserver.selectedEvents,
                    builder: (context, value, _) {
                      print("Initialized Value Notifier: ");
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () => print('${value[index]}'),
                              title: Text('${value[index]}'),
                            ),
                          );
                        },
                      );
                    }),
              )
            ]));
  }
}

// based on https://github.com/aleksanderwozniak/table_calendar/blob/master/example/lib/pages/basics_example.dart