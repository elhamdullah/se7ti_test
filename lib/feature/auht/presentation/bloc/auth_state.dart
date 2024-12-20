class AuthState {}

// initail
class AuthInitial extends AuthState {}

// Register
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

// Login
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String userType;

  LoginSuccessState({required this.userType});
}

// Doctor Registion
class DoctorRegistionLoadingState extends AuthState {}

class DoctorRegistionSuccessState extends AuthState {}

// Error 
class AuhtErrorState extends AuthState {
  final String message;

  AuhtErrorState({required this.message});
}
