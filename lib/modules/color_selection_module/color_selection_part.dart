library color_selection_modules;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/resources/themes.dart';
import 'package:run_app/ui/components/base_color_selection.dart';
import 'package:run_app/ui/components/base_switcher.dart';
import 'package:run_app/ui/components/base_text.dart';
import 'package:run_app/utils/base_cubit.dart';

part 'entities/color_state.dart';
part 'entities/color_theme_state.dart';
part 'entities/theme_state.dart';
part 'presentation/bloc/color_selection_cubit.dart';
part 'presentation/widgets/color_selection_widget.dart';
part 'presentation/widgets/theme_selection_widget.dart';