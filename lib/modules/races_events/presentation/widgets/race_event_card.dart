import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:run_app/modules/races_events/entities/race_event_state.dart';
import 'package:run_app/ui/screens/additional_screens/create_race_screen.dart';
import 'package:run_app/utils/constants.dart';

class RaceEventCard extends StatefulWidget {
  const RaceEventCard({Key? key, required this.raceEvent}) : super(key: key);

  final RaceEvent raceEvent;

  @override
  State<RaceEventCard> createState() => _RaceEventCardState();
}

class _RaceEventCardState extends State<RaceEventCard> {
  final borderRadius = BorderRadius.circular(20);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.only(bottom: 10),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: borderRadius),
      child: Column(
        children: [
          if (widget.raceEvent.photo != null)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 130,
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.network(
                        widget.raceEvent.photo!.isNotEmpty
                            ? widget.raceEvent.photo!
                            : 'https://pp.userapi.com/c625829/v625829051/38fb/IurtvlBPMwc.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.raceEvent.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        "${widget.raceEvent.distance / 1000} км",
                        style: const TextStyle(
                          color: Color(0xFF70B0FB),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          formatDateTimeEvent.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.raceEvent.startDate)),
                          style: const TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          widget.raceEvent.address,
                          style: const TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        /*style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF70B0FB),
                          ), // Цвет кнопки
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),*/
                        elevation: 0,
                        disabledElevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        hoverElevation: 0,
                        color: const Color(0xFF70B0FB),
                        shape: const RoundedRectangleBorder(
                            //side: new BorderSide(color: Color(0xFF2A8068)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          'Записаться на забег',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => CreateRaceScreen(
                                  raceEvent: widget.raceEvent,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Color(0xFF70B0FB))),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Описание",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
