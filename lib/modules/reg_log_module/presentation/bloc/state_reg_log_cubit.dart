import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/reg_log_module/domain/rep/reg_log_firebase_rep.dart';
import 'package:run_app/modules/reg_log_module/entities/state_reg_log.dart';
import 'package:run_app/utils/base_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class StateRegLogCubit extends Cubit<StateRegLog> with BaseCubit<StateRegLog> {
  final RegLogFirebaseRep regLogFirebaseRep;

  StateRegLogCubit(this.regLogFirebaseRep) : super(StateRegLog.authorization){

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("workcubit");

      if(user == null){
        print("Null user");
      }
      else{
        switchApplication();
      }
    });
  }

  void switchAuthorization() => emit(StateRegLog.authorization);
  void switchRegistration() => emit(StateRegLog.registration);
  void switchApplication() => emit(StateRegLog.application);
  void switchNoRegistration() => emit(StateRegLog.noRegistration);


  signInWithGoogle() async {
    User? user;
    user = await regLogFirebaseRep.signInWithGoogle().then((value){
      return null;
    });


    if(user == null){

    }
    else{
      switchApplication();
    }
  }
  
  signUp(String email, String password) async {
    User? user;
    user = await regLogFirebaseRep.signUp(email, password);
  }

  signIn(String email, String password) async {
    User? user;
    user = await regLogFirebaseRep.signIn(email, password);
  }

  void signInWithApple() {}
}