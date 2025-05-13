import 'irrigation_model.dart'; // Import your IrrigationModel class

class SegmentModel {
  final String id;
  final String name;
  final String description;
  final int horizontalPalms;
  final int verticalPalms;
  final double sizeInFaddan;
  final int personType;
  final double personCost;
  final double landServiceCost;
  final double equipmentUsedCost;

  // Generator details
  final double generatorTotalHours;
  final String generatorType;
  final String generatorName;
  final double generatorElectricityInvoice;
  final double generatorOilPrice;
  final double generatorMaintenanceCost;
  final double generatorOilChange;
  final double generatorFiltersCost;

  // Agricultural details
  final double fertilizingPrice;
  final double contractorPersonsCost;
  final double landWorkPrice;
  final double equipmentCost;

  // Irrigation
  final double irrigationTransportCost;
  final List<IrrigationModel> irrigationItems;

  SegmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.horizontalPalms,
    required this.verticalPalms,
    required this.sizeInFaddan,
    required this.personType,
    required this.personCost,
    required this.landServiceCost,
    required this.equipmentUsedCost,
    required this.generatorTotalHours,
    required this.generatorType,
    required this.generatorName,
    required this.generatorElectricityInvoice,
    required this.generatorOilPrice,
    required this.generatorMaintenanceCost,
    required this.generatorOilChange,
    required this.generatorFiltersCost,
    required this.fertilizingPrice,
    required this.contractorPersonsCost,
    required this.landWorkPrice,
    required this.equipmentCost,
    required this.irrigationTransportCost,
    required this.irrigationItems,
  });

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      horizontalPalms: json['horizontalPalms'],
      verticalPalms: json['verticalPalms'],
      sizeInFaddan: (json['sizeInFaddan'] as num).toDouble(),
      personType: json['personType'],
      personCost: (json['personCost'] as num).toDouble(),
      landServiceCost: (json['landServiceCost'] as num).toDouble(),
      equipmentUsedCost: (json['equipmentUsedCost'] as num).toDouble(),
      generatorTotalHours: (json['generatorTotalHours'] as num).toDouble(),
      generatorType: json['generatorType'],
      generatorName: json['generatorName'],
      generatorElectricityInvoice: (json['generatorElectricityInvoice'] as num).toDouble(),
      generatorOilPrice: (json['generatorOilPrice'] as num).toDouble(),
      generatorMaintenanceCost: (json['generatorMaintenanceCost'] as num).toDouble(),
      generatorOilChange: (json['generatorOilChange'] as num).toDouble(),
      generatorFiltersCost: (json['generatorFiltersCost'] as num).toDouble(),
      fertilizingPrice: (json['fertilizingPrice'] as num).toDouble(),
      contractorPersonsCost: (json['contractorPersonsCost'] as num).toDouble(),
      landWorkPrice: (json['landWorkPrice'] as num).toDouble(),
      equipmentCost: (json['equipmentCost'] as num).toDouble(),
      irrigationTransportCost: (json['irrigationTransportCost'] as num).toDouble(),
      irrigationItems: (json['irrigationItems'] as List<dynamic>)
          .map((e) => IrrigationModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'horizontalPalms': horizontalPalms,
      'verticalPalms': verticalPalms,
      'sizeInFaddan': sizeInFaddan,
      'personType': personType,
      'personCost': personCost,
      'landServiceCost': landServiceCost,
      'equipmentUsedCost': equipmentUsedCost,
      'generatorTotalHours': generatorTotalHours,
      'generatorType': generatorType,
      'generatorName': generatorName,
      'generatorElectricityInvoice': generatorElectricityInvoice,
      'generatorOilPrice': generatorOilPrice,
      'generatorMaintenanceCost': generatorMaintenanceCost,
      'generatorOilChange': generatorOilChange,
      'generatorFiltersCost': generatorFiltersCost,
      'fertilizingPrice': fertilizingPrice,
      'contractorPersonsCost': contractorPersonsCost,
      'landWorkPrice': landWorkPrice,
      'equipmentCost': equipmentCost,
      'irrigationTransportCost': irrigationTransportCost,
      'irrigationItems': irrigationItems.map((e) => e.toJson()).toList(),
    };
  }
}
