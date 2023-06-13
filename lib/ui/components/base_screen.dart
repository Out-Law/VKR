import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_app/modules/language_selection_module/presentation/bloc/language_selection_bloc.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
        ),
      ),
      body: BlocBuilder<LocaleCubit, String>(
          builder: (context, state) {
          return Localizations.override(
            context: context,
            locale: Locale(state),
              child: SafeArea(
                child: child,
              ),
          );
        })
    );
  }
}
