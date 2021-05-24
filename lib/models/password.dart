import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
    // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value!)
        ? null
        : PasswordValidationError.invalid;
  }
}