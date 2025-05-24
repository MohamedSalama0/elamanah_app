import 'package:farm_project/core/models/constant_workers_model.dart';
import 'package:farm_project/core/models/generator_model.dart';


class FarmConfigModel {
  final GeneratorModel generator;
  final ConstantWorkerModel constantWorker;

  FarmConfigModel({
    required this.generator,
    required this.constantWorker,
  });

  factory FarmConfigModel.fromJson(Map<String, dynamic> json) {
    return FarmConfigModel(
      generator: GeneratorModel.fromJson(json['generator']),
      constantWorker: ConstantWorkerModel.fromJson(json['constant_worker']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generator': generator.toJson(),
      'constant_worker': constantWorker.toJson(),
    };
  }
}
