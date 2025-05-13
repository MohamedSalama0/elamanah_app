part of 'segment_cubit.dart';

abstract class SegmentState {}

class SegmentInitial extends SegmentState {}

class SegmentLoading extends SegmentState {}

class SegmentSuccess extends SegmentState {}

class SegmentFailure extends SegmentState {
  final String message;
  SegmentFailure(this.message);
}



class SegmentUpdateCalculationLoading extends SegmentState {}

class SegmentUpdateCalculationSuccess extends SegmentState {}

class SegmentUpdateCalculationFailure extends SegmentState {
  final String message;
  SegmentUpdateCalculationFailure(this.message);
}
