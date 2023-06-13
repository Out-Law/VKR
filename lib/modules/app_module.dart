import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:run_app/modules/app_module.config.dart';


@module
abstract class AppModule {}

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
configureDependencies(String environment) =>
    $initGetIt(GetIt.I, environment: environment);
