part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class ToggleState extends AuthState {}

class SigningUser extends AuthState {}

class SignedUser extends AuthState {}

class LogingUser extends AuthState {}

class LogedUser extends AuthState {}

class GettingToken extends AuthState {}

class GotToken extends AuthState {}

class AuthError extends AuthState {}
