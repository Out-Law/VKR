import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:run_app/ui/components/base_background_container.dart';

class DataRunWeekStatistics extends StatelessWidget {
  const DataRunWeekStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBackgroundContainer(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Chart(
        layers: layers(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(
          bottom: 12.0,
        ),
      ),
    );
  }

  List<ChartLayer> layers() {
    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: 1.0,
            max: 13.0,
            min: 7.0,
            textStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: 100.0,
            max: 300.0,
            min: 0.0,
            textStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => value.toInt().toString(),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartBarLayer(
        items: List.generate(
              7,
              (index) => ChartBarDataItem(
            color: const Color(0xFF8043F9),
            value: Random().nextInt(280) + 20,
            x: index.toDouble() + 7,
          ),
        ),
        settings: const ChartBarSettings(
          thickness: 8.0,
          radius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    ];
  }
}
