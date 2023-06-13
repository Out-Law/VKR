import 'package:flutter/material.dart';

class DayModule extends StatefulWidget {
  final String name; // Название дня недели
  final String day; // Номер дня месяца
  final ValueChanged<bool>? onSelect; // Колбэк, вызываемый при нажатии на день
  final bool isActive; // Флаг, показывающий, активен ли день

  const DayModule({
    Key? key,
    required this.name,
    required this.day,
    this.onSelect,
    required this.isActive,
  }) : super(key: key);

  @override
  _DayModuleState createState() => _DayModuleState();
}

class _DayModuleState extends State<DayModule> {
  // Геттер для получения значения активности из виджета
  bool get _isActive => widget.isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onSelect != null) {
          widget.onSelect!(!_isActive);
        }
      },
      child: Container(
        height: 80,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _isActive ? Colors.blue : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            Text(
              widget.day,
              style: TextStyle(
                color: _isActive ? Colors.white : const Color(0xFF283C4D),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _isActive ? Colors.white : const Color(0x40283C4D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}