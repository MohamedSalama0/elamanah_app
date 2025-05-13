class PalmModel {
  final String id;

  final int coordX;
  final int coordY;
  final double waterCharge;
  final double fertilizeCharge;
  final double contractorCharge;
  final double electricityCharge;
  final double irrigateCharge;
  final double landCharge;
  final String? image;

  PalmModel({
    required this.id,
    required this.coordX,
    required this.coordY,
    required this.waterCharge,
    required this.fertilizeCharge,
    required this.contractorCharge,
    required this.electricityCharge,
    required this.irrigateCharge,
    required this.landCharge,
    this.image,
  });

  factory PalmModel.fromJson(Map<String, dynamic> json, String docId) {
    return PalmModel(
      id: docId,
      coordX: json['coordX'] as int,
      coordY: json['coordY'] as int,
      waterCharge: (json['waterCharge'] as num).toDouble(),
      fertilizeCharge: (json['fertilizeCharge'] as num).toDouble(),
      contractorCharge: (json['contractorCharge'] as num).toDouble(),
      electricityCharge: (json['electricityCharge'] as num).toDouble(),
      irrigateCharge: (json['irrigateCharge'] as num).toDouble(),
      landCharge: (json['landCharge'] as num).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'coordX': coordX,
      'coordY': coordY,
      'waterCharge': waterCharge,
      'fertilizeCharge': fertilizeCharge,
      'contractorCharge': contractorCharge,
      'electricityCharge': electricityCharge,
      'irrigateCharge': irrigateCharge,
      'landCharge': landCharge,
      'image': image,
    };
  }

  PalmModel copyWith({
    String? id,
    int? coordX,
    int? coordY,
    double? waterCharge,
    double? fertilizeCharge,
    double? contractorCharge,
    double? electricityCharge,
    double? irrigateCharge,
    double? landCharge, required double fertlizeCharge,
    String? image,
  }) {
    return PalmModel(
      id: id ?? this.id,
      coordX: coordX ?? this.coordX,
      coordY: coordY ?? this.coordY,
      waterCharge: waterCharge ?? this.waterCharge,
      fertilizeCharge: fertilizeCharge ?? this.fertilizeCharge,
      contractorCharge: contractorCharge ?? this.contractorCharge,
      electricityCharge: electricityCharge ?? this.electricityCharge,
      irrigateCharge: irrigateCharge ?? this.irrigateCharge,
      landCharge: landCharge ?? this.landCharge,
      image: image ?? this.image,
    );
  }
}
