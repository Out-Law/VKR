import 'package:flutter/material.dart';
import 'day_module.dart';

class CalendarSlider extends StatefulWidget {
  final ValueChanged<bool> onDaySelection;

  const CalendarSlider({Key? key, required this.onDaySelection})
      : super(key: key);

  @override
  _CalendarSliderState createState() => _CalendarSliderState();
}

class _CalendarSliderState extends State<CalendarSlider> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _days = List.generate(31, (index) => '${index + 1}');
  final List<String> _weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  ValueNotifier<int> _selectedDay = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82.0,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 8.0);
        },
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (BuildContext context, int index) {
          return ValueListenableBuilder<int>(
            valueListenable: _selectedDay,
            builder: (BuildContext context, int value, Widget? child) {
              return DayModule(
                name: _weekDays[index % 7],
                day: _days[index],
                onSelect: (isActive) {
                  if (isActive) {
                    _selectedDay.value = index;
                  } else {
                    _selectedDay.value = 0;
                  }
                },
                isActive: index == _selectedDay.value,
              );
            },
          );
        },
      ),
    );
  }
}