part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetImageSuccefully extends AppState{}

class GetImageError extends AppState{
  final String message;
  GetImageError(this.message);
}

class CroppedSuccessfully extends AppState{}

class CroppedError extends AppState{
  final String message;
  CroppedError(this.message);
}

class RegisterLoading extends AppState{}
class RegisterSuccessfully extends AppState{}
class RegisterError extends AppState{
  final String message;
  RegisterError(this.message);
}

class SetUserOnline extends AppState{}
class SetUserOffline extends AppState{}

class LoginLoading extends AppState{}
class LoginSuccessfully extends AppState{}
class LoginError extends AppState{
  final String message;
  LoginError(this.message);
}
class UserDataLoading extends AppState{}
class UserDataSuccessfully extends AppState{}
class UserDataError extends AppState{}

class UserEditDataLoading extends AppState{}
class UserEditDataSuccessfully extends AppState{}
class UserEditDataError extends AppState{}

class GetAllUsers extends AppState{}