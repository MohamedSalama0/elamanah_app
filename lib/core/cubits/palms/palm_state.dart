part of 'palm_cubit.dart';

abstract class PalmState {}

class PalmInitial extends PalmState {}

class PalmLoading extends PalmState {}

class PalmSuccess extends PalmState {}

class PalmFailure extends PalmState {
  final String message;
  PalmFailure(this.message);
}

class PalmUpdateLoading extends PalmState {}

class PalmUpdateSuccess extends PalmState {}

class PalmUpdateFailure extends PalmState {
  final String message;
  PalmUpdateFailure(this.message);
}
