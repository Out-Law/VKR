import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/language_selection_module/entities/language.dart';

@injectable
class LocaleCubit extends Cubit<String> {
  LocaleCubit() : super("ru");

  void changeLocalization(Language language) {
    switch (language) {
      case Language.English:
        emit("en");
        break;
      case Language.Russian:
        emit("ru");
        break;
      default:
        throw ArgumentError('Invalid language: $language');
    }
  }
}
