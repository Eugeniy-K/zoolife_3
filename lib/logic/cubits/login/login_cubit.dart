import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:zoolife_2/models/email.dart';
import 'package:zoolife_2/models/password.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(const LoginState());

  // final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
    // print(state.status.toString());
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
    print(state.status.toString());
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    // emit(state.copyWith(status: FormzStatus.submissionInProgress));
    // try {
    //   await _authenticationRepository.logInWithEmailAndPassword(
    //     email: state.email.value,
    //     password: state.password.value,
    //   );
    //   emit(state.copyWith(status: FormzStatus.submissionSuccess));
    // } on Exception {
    //   emit(state.copyWith(status: FormzStatus.submissionFailure));
    // }
  }
}