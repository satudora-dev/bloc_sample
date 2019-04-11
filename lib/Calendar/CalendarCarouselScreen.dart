import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class CalendarCarouselScreen extends StatefulWidget {
  @override
  _CalendarCarouselState createState() => new _CalendarCarouselState();
}

class _CalendarCarouselState extends State<CalendarCarouselScreen> {
  DateTime _currentDate = DateTime(2019, 1, 3);
  DateTime _currentDate2 = DateTime(2019, 1, 3);
  String _currentMonth = '';

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2018, 12, 10): [
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 1',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2018, 12, 25),
        new Event(
          date: new DateTime(2018, 12, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2018, 12, 10),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2018, 12, 11), [
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 350.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateMoreShowTotal: false,
      // null for not showing hidden events indicator
      //showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.green,
      ),
      minSelectedDate: _currentDate,
      maxSelectedDate: _currentDate.add(Duration(days: 60)),
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
      locale: "ja",
    );

    return new Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[
          Row(children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //custom icon
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: _calendarCarousel,
                    ), // This trailing comma makes auto-formatting nicer for build methods.
                  ],
                ),
              ),
            ),
          ]),
        ]));
  }
}
