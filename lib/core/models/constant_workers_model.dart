class ConstantWorkerModel {
  final int type; // 1: Internal, 2: Contractor
  final double cost;

  ConstantWorkerModel({
    required this.type,
    required this.cost,
  });

  factory ConstantWorkerModel.fromJson(Map<String, dynamic> json) {
    return ConstantWorkerModel(
      type: json['type'],
      cost: (json['cost'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'cost': cost,
    };
  }
}
