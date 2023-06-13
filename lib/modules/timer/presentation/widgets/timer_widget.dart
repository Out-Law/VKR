import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_app/modules/timer/entities/timer_state.dart';
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart';
import 'package:run_app/ui/components/base_text.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          final hours = state.duration.inHours;
          final minutes = state.duration.inMinutes % 60;
          final seconds = state.duration.inSeconds % 60;
          return Row(
            children: [
              AnimatedFlipCounter(
                  value: hours,
                  wholeDigits: 2,
                  duration: const Duration(milliseconds: 500),
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  )
              ),
              const BaseText(
                title: ":",
                size: 15,
                fontWeight: FontWeight.bold,
              ),
              AnimatedFlipCounter(
                  value: minutes,
                  wholeDigits: 2,
                  duration: const Duration(milliseconds: 500),
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  )
              ),
              const BaseText(
                title: ":",
                size: 15,
                fontWeight: FontWeight.bold,
              ),
              AnimatedFlipCounter(
                value: seconds,
                wholeDigits: 2,
                duration: const Duration(milliseconds: 500),
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                )
              ),
            ],
          );
        },
      );
  }
}
