part of '../../data_run_part.dart';

class DataRunAboveMap extends StatelessWidget {
  final Function() onOpenInformationRun;
  const DataRunAboveMap({
    Key? key,
    required this.onOpenInformationRun
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataRunCubit, DataRunState>(
        builder: (ctx, value) {
          return BaseBackgroundContainer(
              color: Colors.white,
              child: Stack(
                children: [
                  IconButton(
                    onPressed: (){
                      onOpenInformationRun();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/back_arrow.svg",
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 115, right: 115, top: 12, bottom: 20),
                        child: Column(
                          children: [
                            const BaseText(
                                title: "Забег",
                                size: 20,
                                fontWeight: FontWeight.w500,
                            ),
                            BaseText(
                                title: "${value.distance} км",
                                size: 25,
                                fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TimerWidget(),
                            /*ElementsData(
                              value: "${value.time.hours}:${value.time.minutes}:${value.time.seconds}",
                              title: "Время",
                              icon: "assets/icons/time.svg",
                            ),*/
                            ElementsData(
                                value: "${value.temp}",
                                title: "Ср. темп",
                                icon: "assets/icons/temp.svg"
                            ),
                            ElementsData(
                                value: "${value.calories}",
                                title: "Калр",
                                icon: "assets/icons/fire.svg"
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
          );
        });
  }
}

