part of '../../bottom_button_run_part.dart';

@injectable
class BottomButtonRunCubit extends Cubit<StateBottomButtonRun> with BaseCubit<StateBottomButtonRun> {

  BottomButtonRunCubit() : super(StateBottomButtonRun.initialState);

  void switchInitialState() => emit(StateBottomButtonRun.initialState);
  void switchOpenMapState() => emit(StateBottomButtonRun.openMapState);
  void switchRunState() => emit(StateBottomButtonRun.runState);

}