import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/data_run/presentation/widgets/data_run_all_statistics.dart';
import 'package:run_app/modules/data_run/presentation/widgets/data_run_main_statistics.dart';
import 'package:run_app/modules/data_run/presentation/widgets/data_run_week_statistics.dart';
import 'package:run_app/modules/reg_log_module/entities/state_reg_log.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/rout/app_rout.gr.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/ui/screens/main/run_screen_map.dart';
import 'package:run_app/ui/screens/reg_log_screens/login_screen.dart';
import 'package:run_app/ui/screens/reg_log_screens/sign_up_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StateRegLogCubit, StateRegLog>(builder: (ctx, value) {
      switch (value) {
        case StateRegLog.application:
          return BaseScreen(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 15),
                      child: Column(
                        children: [
                          appBar(context),
                          Container(
                              margin: const EdgeInsets.only(top: 16),
                              height: 160,
                              child: const HomePage()),
                          Container(
                              margin: const EdgeInsets.only(top: 16),
                              height: 160,
                              child: const DataRunWeekStatistics()),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: _buildCalendarDialogButton(context),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            child: const DataRunAllStatistics(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        case StateRegLog.noRegistration:
          return const RunScreen();
        case StateRegLog.authorization:
          return const LoginScreen();
        case StateRegLog.registration:
          return const SignUpScreen();
        default:
          return const LoginScreen();
      }
    });
  }
}

Widget appBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IconButton(
        onPressed: () {
          context.read<StateRegLogCubit>().switchAuthorization();
        },
        icon: SvgPicture.asset(
          "assets/icons/exit.svg",
        ),
      ),
      SizedBox(
        height: 105,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/imgs/photo.png"),
            const Text(
              "Добро пожаловать,\nЕлена!",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      IconButton(
        onPressed: () {
          context.router.push(const SettingsScreenRoute());
        },
        icon: SvgPicture.asset(
          "assets/icons/settings.svg",
        ),
      ),
    ],
  );
}


///Временный календарь
List<DateTime?> _dialogCalendarPickerValue = [
  DateTime(2023, 5, 17),
  DateTime(2023, 5, 20),
];

String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
    ) {
  values =
      values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
  var valueText = (values.isNotEmpty ? values[0] : null)
      .toString()
      .replaceAll('00:00:00.000', '');

  if (datePickerType == CalendarDatePicker2Type.multi) {
    valueText = values.isNotEmpty
        ? values
        .map((v) => v.toString().replaceAll('00:00:00.000', ''))
        .join(', ')
        : 'null';
  } else if (datePickerType == CalendarDatePicker2Type.range) {
    if (values.isNotEmpty) {
      final startDate = values[0].toString().replaceAll('00:00:00.000', '');
      final endDate = values.length > 1
          ? values[1].toString().replaceAll('00:00:00.000', '')
          : 'null';
      valueText = '$startDate to $endDate';
    } else {
      return 'null';
    }
  }

  return valueText;
}

_buildCalendarDialogButton(BuildContext context) {
  const dayTextStyle =
  TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
  final weekendTextStyle =
  TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
  final anniversaryTextStyle = TextStyle(
    color: Colors.red[400],
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );
  final config = CalendarDatePicker2WithActionButtonsConfig(
    dayTextStyle: dayTextStyle,
    calendarType: CalendarDatePicker2Type.range,
    selectedDayHighlightColor: Colors.purple[800],
    closeDialogOnCancelTapped: true,
    firstDayOfWeek: 1,
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    centerAlignModePicker: true,
    customModePickerIcon: const SizedBox(),
    selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
    dayTextStylePredicate: ({required date}) {
      TextStyle? textStyle;
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        textStyle = weekendTextStyle;
      }
      if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
        textStyle = anniversaryTextStyle;
      }
      return textStyle;
    },
    dayBuilder: ({
      required date,
      textStyle,
      decoration,
      isSelected,
      isDisabled,
      isToday,
    }) {
      Widget? dayWidget;
      if (date.day % 3 == 0 && date.day % 9 != 0) {
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  MaterialLocalizations.of(context).formatDecimal(date.day),
                  style: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.5),
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isSelected == true
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return dayWidget;
    },
    yearBuilder: ({
      required year,
      decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
    }) {
      return Center(
        child: Container(
          decoration: decoration,
          height: 36,
          width: 72,
          child: Center(
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year.toString(),
                    style: textStyle,
                  ),
                  if (isCurrentYear == true)
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            final values = await showCalendarDatePicker2Dialog(
              context: context,
              config: config,
              dialogSize: const Size(325, 400),
              borderRadius: BorderRadius.circular(15),
              value: _dialogCalendarPickerValue,
              dialogBackgroundColor: Colors.white,
            );
            if (values != null) {
              // ignore: avoid_print
              print(_getValueText(
                config.calendarType,
                values,
              ));

                _dialogCalendarPickerValue = values;
            }
          },
          child: const Text('Open Calendar Dialog'),
        ),
      ],
    ),
  );
}
