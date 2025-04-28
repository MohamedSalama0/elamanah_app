class FertilizerModel {
  final String generatorId;
  final double hoursElectricity;
  final double price;

  FertilizerModel({
    required this.generatorId,
    required this.hoursElectricity,
    required this.price,
  });

  factory FertilizerModel.fromJson(Map<String, dynamic> json) {
    return FertilizerModel(
      generatorId: json['generatorId'] as String,
      hoursElectricity: (json['hoursElectricity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generatorId': generatorId,
      'hoursElectricity': hoursElectricity,
      'price': price,
    };
  }
}
