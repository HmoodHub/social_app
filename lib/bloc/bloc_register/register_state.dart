part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterError extends RegisterState {}
class RegisterVisibilityPass extends RegisterState {}
class SetUsernameSuccess extends RegisterState {}
class SetUsernameError extends RegisterState {}

