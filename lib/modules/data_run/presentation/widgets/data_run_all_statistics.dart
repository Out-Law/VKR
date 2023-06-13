import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:run_app/modules/data_run/presentation/widgets/calendar/calendar_slider.dart';
import 'package:run_app/modules/data_run/presentation/widgets/calendar/run_slots_list.dart';
import 'package:run_app/ui/components/base_background_container.dart';

class DataRunAllStatistics extends StatelessWidget {
  const DataRunAllStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBackgroundContainer(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          /*Container(
            padding: const EdgeInsets.only(top: 16),
            child:
                topMenu(leftButton: () {}, rightButton: () {}, label: 'Март'),
          ),
          Container(
            height: 82,
            margin: const EdgeInsets.only(bottom: 20),
            child: CalendarSlider(onDaySelection: (a) {}),
          ),*/
          RunSlotsList(
            onTimeSlotSelection: (a) {},
          ),
        ],
      ),
    );
  }

  Widget topMenu(
      {required Function() leftButton,
      required Function() rightButton,
      required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            leftButton();
          },
          icon: SvgPicture.asset(
            "assets/icons/back_arrow.svg",
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            label,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            rightButton();
          },
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14),
            child: SvgPicture.asset(
              "assets/icons/back_arrow.svg",
            ),
          ),
        )
      ],
    );
  }
}
