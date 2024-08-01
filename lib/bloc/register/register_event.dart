import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String address;
  final String mobile;
  final String otp;
  final String password;

  RegisterButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.mobile,
    required this.otp,
    required this.password
  });

  @override
  List<Object> get props => [firstName, lastName, address, mobile, otp, password];
}
