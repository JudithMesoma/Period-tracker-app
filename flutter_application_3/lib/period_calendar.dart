import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodCalendar extends StatefulWidget {
  final int cycleLength;
  final int menstruationLength;
  final DateTime lastPeriodStart;

  const PeriodCalendar({
    super.key,
    required this.cycleLength,
    required this.menstruationLength,
    required this.lastPeriodStart,
  });

  @override
  _PeriodCalendarState createState() => _PeriodCalendarState();
}

class _PeriodCalendarState extends State<PeriodCalendar> {
  late Map<DateTime, Map<String, String>> events;
  late DateTime focusedDay;
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    selectedDay = focusedDay;
    events = _generateEvents(widget.lastPeriodStart, widget.cycleLength, widget.menstruationLength);
  }

  Map<DateTime, Map<String, String>> _generateEvents(
      DateTime startDate, int cycleLength, int menstruationLength) {
    Map<DateTime, Map<String, String>> generatedEvents = {};
    DateTime currentDate = startDate;

    while (currentDate.isBefore(DateTime.now().add(const Duration(days: 365)))) {
      for (int day = 0; day < cycleLength; day++) {
        DateTime eventDate = currentDate.add(Duration(days: day));
        if (day < menstruationLength) {
          generatedEvents[eventDate] = {
            'phase': 'Menstruation',
            'description': 'Rest, hydrate, and avoid stress.'
          };
        } else if (day < (cycleLength / 2 - 1).ceil()) {
          generatedEvents[eventDate] = {
            'phase': 'Follicular Phase',
            'description': 'Focus on light exercises and self-care.'
          };
        } else if (day == (cycleLength / 2 - 1).ceil()) {
          generatedEvents[eventDate] = {
            'phase': 'Ovulation',
            'description': 'Fertility is highest. Stay active and eat healthy.'
          };
        } else {
          generatedEvents[eventDate] = {
            'phase': 'Luteal Phase',
            'description': 'Prepare for menstruation. Avoid fatty foods.'
          };
        }
      }
      currentDate = currentDate.add(Duration(days: cycleLength));
    }
    return generatedEvents;
  }

  Map<String, String>? _getEventForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)];
  }

  Color _getMarkerColor(String phase) {
    switch (phase) {
      case 'Menstruation':
        return Colors.red;
      case 'Ovulation':
        return Colors.green;
      case 'Follicular Phase':
        return Colors.blue;
      case 'Luteal Phase':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is Your Period Calendar'),
        backgroundColor: Colors.pink.withOpacity(0.4),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHD8PlMytcDjNLdRnfHiGIynkOLRC9MFg92A&s',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Column(
            children: [
              // Phase Descriptions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPhaseDescription('Menstruation', Colors.red, 'Menstruation is the shedding of the uterine lining (endometrium) that occurs when pregnancy does not happen. It marks the start of a new menstrual cycle, typically lasting 3-7 days.'),
                    const SizedBox(height: 8),
                    _buildPhaseDescription('Ovulation', Colors.green, 'Ovulation is the release of a mature egg from the ovary, typically around the midpoint of the cycle (day 14 in a 28-day cycle).'),
                    const SizedBox(height: 8),
                    _buildPhaseDescription('Follicular Phase', Colors.blue, 'This phase begins on the first day of menstruation and lasts until ovulation (usually around day 1 to day 14 of a 28-day cycle).'),
                    const SizedBox(height: 8),
                    _buildPhaseDescription('Luteal Phase', Colors.orange, 'This phase follows ovulation and lasts about 14 days.'),
                  ],
                ),
              ),
              const Divider(),
              // Calendar in a Box
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.pink, width: 2),
                ),
                child: TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                    markersAlignment: Alignment.bottomCenter,
                  ),
                  eventLoader: (day) {
                    final event = _getEventForDay(day);
                    if (event != null) {
                      return [event['phase'] ?? ''];
                    }
                    return [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        final phase = events.first as String;
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getMarkerColor(phase),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Event Details for Selected Day
              if (_getEventForDay(selectedDay) != null)
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          color: Colors.purple.shade50,
                          child: ListTile(
                            leading: const Icon(
                              Icons.info,
                              color: Colors.purple,
                            ),
                            title: Text(
                              '${_getEventForDay(selectedDay)?['phase']}: ${_getEventForDay(selectedDay)?['description']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text(
                      'No events for this day.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseDescription(String phaseName, Color dotColor, String description) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$phaseName: $description',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
