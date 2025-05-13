class IrrigationModel {
   double pipeSize;
   String segmentId;
   double length;
   double width;
   double price;
   int count;

  IrrigationModel({
    required this.pipeSize,
    required this.segmentId,
    required this.length,
    required this.width,
    required this.price,
    required this.count,
  });

  factory IrrigationModel.fromJson(Map<String, dynamic> json) {
    return IrrigationModel(
      pipeSize: (json['pipeSize'] as num).toDouble(),
      segmentId: json['segmentId'] as String,
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pipeSize': pipeSize,
      'segmentId': segmentId,
      'length': length,
      'width': width,
      'price': price,
      'count': count,
    };
  }
}
