class GeneratorModel {
  final double totalHours;
  final String type;
  final String name;
  final double electricityInvoice;
  final double oilPrice;
  final double maintenanceCost;
  final double oilChange;
  final double filtersCost;

  GeneratorModel({
    required this.totalHours,
    required this.type,
    required this.name,
    required this.electricityInvoice,
    required this.oilPrice,
    required this.maintenanceCost,
    required this.oilChange,
    required this.filtersCost,
  });

  factory GeneratorModel.fromJson(Map<String, dynamic> json) {
    return GeneratorModel(
      totalHours: (json['generatorTotalHours'] as num).toDouble(),
      type: json['generatorType'],
      name: json['generatorName'],
      electricityInvoice: (json['generatorElectricityInvoice'] as num).toDouble(),
      oilPrice: (json['generatorOilPrice'] as num).toDouble(),
      maintenanceCost: (json['generatorMaintenanceCost'] as num).toDouble(),
      oilChange: (json['generatorOilChange'] as num).toDouble(),
      filtersCost: (json['generatorFiltersCost'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generatorTotalHours': totalHours,
      'generatorType': type,
      'generatorName': name,
      'generatorElectricityInvoice': electricityInvoice,
      'generatorOilPrice': oilPrice,
      'generatorMaintenanceCost': maintenanceCost,
      'generatorOilChange': oilChange,
      'generatorFiltersCost': filtersCost,
    };
  }
}
