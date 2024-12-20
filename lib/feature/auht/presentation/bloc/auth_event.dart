import 'package:se7ety_123/feature/auht/data/doctor_model.dart';

class AuthEvent {}

// register
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String userType;

  RegisterEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.userType});
}

// login
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String userType;

  LoginEvent(
      {required this.email, required this.password, required this.userType});
}

// DoctorRegistion
class UpdateDoctorDataEvent extends AuthEvent {
  final DoctorModel doctorModel;

  UpdateDoctorDataEvent({
    required this.doctorModel,
  });
}
