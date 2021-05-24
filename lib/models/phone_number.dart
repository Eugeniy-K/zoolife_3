import 'package:formz/formz.dart';

enum PhoneNumberValidError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numberRegExp = RegExp(
    // r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$',
    r'^(?:7)?[0-9]{11}$'
  );

  @override
  PhoneNumberValidError? validator(String? value) {
    return _numberRegExp.hasMatch(value!) ? null : PhoneNumberValidError.invalid;
  }

}