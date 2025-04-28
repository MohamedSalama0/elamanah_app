class PalmModel {
  final int coordX;
  final int coordY;
  final double waterCharge;
  final double fertilizeCharge;
  final double contractorCharge;
  final double electricityCharge;
  final double irrigateCharge;
  final double landCharge;

  PalmModel({
    required this.coordX,
    required this.coordY,
    required this.waterCharge,
    required this.fertilizeCharge,
    required this.contractorCharge,
    required this.electricityCharge,
    required this.irrigateCharge,
    required this.landCharge,
  });

  factory PalmModel.fromJson(Map<String, dynamic> json) {
    return PalmModel(
      coordX: json['coordX'] as int,
      coordY: json['coordY'] as int,
      waterCharge: (json['waterCharge'] as num).toDouble(),
      fertilizeCharge: (json['fertilizeCharge'] as num).toDouble(),
      contractorCharge: (json['contractorCharge'] as num).toDouble(),
      electricityCharge: (json['electricityCharge'] as num).toDouble(),
      irrigateCharge: (json['irrigateCharge'] as num).toDouble(),
      landCharge: (json['landCharge'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordX': coordX,
      'coordY': coordY,
      'waterCharge': waterCharge,
      'fertilizeCharge': fertilizeCharge,
      'contractorCharge': contractorCharge,
      'electricityCharge': electricityCharge,
      'irrigateCharge': irrigateCharge,
      'landCharge': landCharge,
    };
  }
}
