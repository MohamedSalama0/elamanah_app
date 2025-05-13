

abstract class SectorState {}

class SectorInitial extends SectorState {}

class SectorLoading extends SectorState {}

class SectorSuccess extends SectorState {
  SectorSuccess();
}

class SectorFailure extends SectorState {
  final String message;
  SectorFailure(this.message);
}
