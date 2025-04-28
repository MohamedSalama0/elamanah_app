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
  });

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      horizontalPalms: json['horizontalPalms'] as int,
      verticalPalms: json['verticalPalms'] as int,
      sizeInFaddan: (json['sizeInFaddan'] as num).toDouble(),
      personType: json['personType'] as int,
      personCost: (json['personCost'] as num).toDouble(),
      landServiceCost: (json['landServiceCost'] as num).toDouble(),
      equipmentUsedCost: (json['equipmentUsedCost'] as num).toDouble(),
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
    };
  }
}
