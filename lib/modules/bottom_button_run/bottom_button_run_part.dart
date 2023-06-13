library bottom_button_run_library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/reg_log_module/entities/state_reg_log.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/modules/timer/entities/timer_event.dart';
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart';
import 'package:run_app/rout/app_rout.gr.dart';
import 'package:run_app/utils/base_cubit.dart';

part 'presentation/bloc/bottom_button_run_cubit.dart';
part 'presentation/widgets/bottom_button_run_widget.dart';
part 'entities/state_bottom_button_run.dart';