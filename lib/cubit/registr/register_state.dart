part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure({required this.errorMessage});
}

class RegisterChangePasswordStyle1 extends RegisterState {}

class RegisterChangePasswordStyle2 extends RegisterState {}
