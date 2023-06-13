import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:run_app/ui/components/base_background_container.dart';

class NewProgressIndicator extends StatefulWidget {
  final double maxValue;
  final double stepValue;

  const NewProgressIndicator(
      {required this.maxValue, required this.stepValue, Key? key})
      : super(key: key);

  @override
  State<NewProgressIndicator> createState() => _NewProgressIndicatorState();
}

class _NewProgressIndicatorState extends State<NewProgressIndicator> {
  List<ChartGroupPieDataItem> one = [];
  List<ChartGroupPieDataItem> two = [];

  double gapSweepAngle = 6;

  void setGapSweepAngle() {
    if (widget.maxValue - widget.stepValue <= 0) {
      gapSweepAngle = 0;
      setState(() {});
    } else {
      gapSweepAngle = 6;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setGapSweepAngle();

    one = [
      ChartGroupPieDataItem(
          amount: widget.stepValue, color: Colors.blue, label: ''),
      ChartGroupPieDataItem(
          amount: widget.maxValue - widget.stepValue,
          color: Colors.grey,
          label: '')
    ];

    if (widget.stepValue >= widget.maxValue) {
      two = [
        ChartGroupPieDataItem(
            amount: widget.stepValue, color: Colors.blue, label: ''),
        ChartGroupPieDataItem(
            amount: widget.maxValue - (widget.stepValue - widget.maxValue),
            color: Colors.grey,
            label: '')
      ];
    } else {
      two = [];
    }

    return Chart(
      layers: layers(),
    );
  }

  List<ChartLayer> layers() {
    return [
      ChartGroupPieLayer(
        items: [one, two],
        /*  items: List.generate(
          1, (index) => List.generate( 3,
                (index) => []
          ),
        ),*/
        settings: const ChartGroupPieSettings(
          gapSweepAngle: 10,
          thickness: 6.0,
        ),
      ),
    ];
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation sizeAnimation;

  late double _distance = 72 * _getValues / 1000;
  late double _calorie = 0.05 * _getValues;

  late double _savePastValue = 0;
  late double _value = 0;
  final double _maxValue = 5000;
  double _getValues = 2500;

  bool replacement = true;

  double getCalorie() {
    _calorie = 0.05 * _getValues;
    return _calorie;
  }

  double getDistance() {
    _distance = 72 * _getValues / 10000;
    return _distance;
  }

  /// функция которая парсит текущее значение в диапазон от 0 до 1
  double currentInterest() {
    _value = _getValues / _maxValue;
    return _value;
  }

  double savePastValue() {
    _savePastValue = _getValues / _maxValue;
    return _savePastValue;
  }

  void balance() {
    if (_getValues > _maxValue) {
      _getValues = _maxValue;
    }
    if (_getValues < 0) {
      _getValues = 0;
    }
  }

  @override
  void initState() {
    super.initState();

    /// дефолтное начало анимаций
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    /// значение промежутка анимации
    sizeAnimation =
        Tween<double>(begin: 0.0, end: currentInterest()).animate(controller);
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  /// очистка для предотвращения утечек
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    balance();
    getDistance();
    getCalorie();

    return SizedBox(
      height: 130,
      child: BaseBackgroundContainer(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            SizedBox(
              width: 116,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  NewProgressIndicator(
                    maxValue: _maxValue,
                    stepValue: _getValues + 2500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 16,
                        height: 20,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${_getValues.toInt()}",
                              style: const TextStyle(fontSize: 13)),
                          Container(
                            margin: const EdgeInsets.only(top: 4, bottom: 4),
                            height: 1,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: Colors.black),
                          ),
                          Text(
                            "${_maxValue.toInt()}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 130,
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Сегодня",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Text(
                        "Растояние - ${_distance.toInt()} км",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 14,
                        height: 16,
                        color: const Color(0xFF5EB95C),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Калории - ${_calorie.toInt()} ккал",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: 14,
                        height: 17,
                        color: const Color(0xFFFF8515),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
