class GeneratorModel {
  final String segmentId;
  final double solarPrice;
  final double hours;
  final double electricityCharge;
  final double maintenanceCost;
  final double changeOilCost;
  final double filtersCost;

  GeneratorModel({
    required this.segmentId,
    required this.solarPrice,
    required this.hours,
    required this.electricityCharge,
    required this.maintenanceCost,
    required this.changeOilCost,
    required this.filtersCost,
  });

  factory GeneratorModel.fromJson(Map<String, dynamic> json) {
    return GeneratorModel(
      segmentId: json['segmentId'] as String,
      solarPrice: (json['solarPrice'] as num).toDouble(),
      hours: (json['hours'] as num).toDouble(),
      electricityCharge: (json['electricityCharge'] as num).toDouble(),
      maintenanceCost: (json['maintenanceCost'] as num).toDouble(),
      changeOilCost: (json['changeOilCost'] as num).toDouble(),
      filtersCost: (json['filtersCost'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'segmentId': segmentId,
      'solarPrice': solarPrice,
      'hours': hours,
      'electricityCharge': electricityCharge,
      'maintenanceCost': maintenanceCost,
      'changeOilCost': changeOilCost,
      'filtersCost': filtersCost,
    };
  }
}
