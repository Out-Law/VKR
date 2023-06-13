import 'package:flutter/material.dart';
import 'package:run_app/modules/data_run/data_run_part.dart';
import 'package:run_app/modules/data_run/presentation/widgets/calendar/time_slot.dart';

class RunSlotsList extends StatefulWidget {
  final ValueChanged<bool> onTimeSlotSelection;

  const RunSlotsList({Key? key, required this.onTimeSlotSelection})
      : super(key: key);

  @override
  State<RunSlotsList> createState() => _TimeSlotsListState();
}

class _TimeSlotsListState extends State<RunSlotsList>
    with TickerProviderStateMixin {
  final List<DataRunState> _runSlots = [
    DataRunState(
        calories: 601,
        temp: 10.1,
        time: Time(hours: 12, minutes: 0, seconds: 0),
        distance: 9.69,
        routeHistoryLine: [],
        date: '19 Апреля'),
    DataRunState(
        calories: 601,
        temp: 10.1,
        time: Time(hours: 12, minutes: 0, seconds: 0),
        distance: 9.69,
        routeHistoryLine: [],
        date: '18 Апреля'),
    DataRunState(
        calories: 601,
        temp: 10.1,
        time: Time(hours: 12, minutes: 0, seconds: 0),
        distance: 9.69,
        routeHistoryLine: [],
        date: '17 Апреля')
  ];

  int _selectedTimeSlot = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _runSlots.length,
      itemBuilder: (BuildContext context, int index) {
        return TimeSlot(
          timeRange: _runSlots[index].date,
          isActive: index == _selectedTimeSlot,
          onTap: () {
            setState(() {
              _selectedTimeSlot = _selectedTimeSlot == index ? -1 : index;
              widget.onTimeSlotSelection(_selectedTimeSlot != -1);
            });
            _animateTimeSlotSelection();
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 2,
          decoration: BoxDecoration(
            color: Theme.of(context).textTheme.headline1?.color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      },
    );
  }

  /*ListView generateWidgetsStat() {
    final children = <Widget>[];

    for (int i = 0; i < _runSlots.length; i++) {
      children.add(
        TimeSlot(
          timeRange: _runSlots[i].date,
          isActive: i == _selectedTimeSlot,
          onTap: () {
            setState(() {
              _selectedTimeSlot = _selectedTimeSlot == i ? -1 : i;
              widget.onTimeSlotSelection(_selectedTimeSlot != -1);
            });
            _animateTimeSlotSelection();
          },
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }*/

  void _animateTimeSlotSelection() {
    // Создание анимационного контроллера
    AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Создание анимации
    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    // Начальное значение анимации
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animation);

    // Запуск анимации
    controller.forward();
  }
}
