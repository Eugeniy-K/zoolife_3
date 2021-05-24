import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:zoolife_2/models/phone_number.dart';

part 'phone_number_state.dart';

class PhoneNumberCubit extends Cubit<PhoneNumberState> {

  PhoneNumberCubit() : super(const PhoneNumberState());

  void numberChanged(String value) {
    final number = PhoneNumber.dirty(value);
    emit(state.copyWith(
        number: number,
        status: Formz.validate([number])));
    print(state.status.toString() +' ' + number.toString());
  }

  Future<void> logInWithPhoneNum() async {
    if (!state.status.isValidated) return;
  }
}