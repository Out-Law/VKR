import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/data_run/data_run_part.dart';
import 'package:run_app/modules/data_run/presentation/widgets/components/elements_data.dart';
import 'package:run_app/ui/components/base_text.dart';

class RunScreenInformation extends StatelessWidget {
  final Function() onOpenMap;
  const RunScreenInformation({
    Key? key,
    required this.onOpenMap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF2F2F2F), Color(0xFF424141)],
        ),
      ),
      child: Column(
        children: [

          ///Верхний бар
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 45,),
              const BaseText(
                  title: "Бег",
                  size: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
              ),
              IconButton(
                  onPressed: (){
                    onOpenMap();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/map.svg",
                    width: 45,
                    height: 45,
                  )
              ),
            ],
          ),
          const SizedBox(height: 60),
          ///Данные
          BlocBuilder<DataRunCubit, DataRunState>(builder: (ctx, value) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 115, right: 115, top: 12, bottom: 20),
                  child: Column(
                    children: [
                      BaseText(
                        title: "${value.distance}",
                        size: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      const BaseText(
                        title: "км",
                        size: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElementsData(
                      value: "${value.time.hours}:${value.time.minutes}:${value.time.seconds}",
                      title: "Время",
                      color: Colors.white,
                      sizeText: 18,
                    ),
                    ElementsData(
                      value: "${value.temp}",
                      title: "Ср. темп",
                      color: Colors.white,
                      sizeText: 18,
                    ),
                    ElementsData(
                      value: "${value.calories}",
                      title: "Калории",
                      color: Colors.white,
                      sizeText: 18,
                    ),
                  ],
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
