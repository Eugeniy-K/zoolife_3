part of 'phone_number_cubit.dart';

class PhoneNumberState extends Equatable {
  const PhoneNumberState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,});

  final PhoneNumber phoneNumber;
  final FormzStatus status;

  @override
  List<Object?> get props => [phoneNumber, status];

  PhoneNumberState copyWith({PhoneNumber? number, FormzStatus? status}) {
    return PhoneNumberState(
      phoneNumber: number ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }
}