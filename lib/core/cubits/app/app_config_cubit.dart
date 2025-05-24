import 'package:farm_project/core/cubits/app/app_config_states.dart';
import 'package:farm_project/core/models/farm_config_model.dart';
import 'package:farm_project/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppConfigCubit extends Cubit<AppConfigStates> {
  final FirebaseService _firebaseService;

  static AppConfigCubit? _instance;

  factory AppConfigCubit() {
    _instance ??= AppConfigCubit._internal(FirebaseService());
    return _instance!;
  }

  AppConfigCubit._internal(this._firebaseService) : super(AppConfigInitial());

  FarmConfigModel? config;

  final constantWorkerPriceController = TextEditingController();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final hoursController = TextEditingController();
  final invoiceController = TextEditingController();
  final oilPriceController = TextEditingController();
  final maintenanceController = TextEditingController();
  final oilChangeController = TextEditingController();
  final filterCostController = TextEditingController();

  Future<void> fetchAppConfig() async {
    emit(AppConfigLoading());
    try {
      final doc = await _firebaseService.fetchFarmConfig();

      config = doc;

      nameController.text = config!.generator.name;
      typeController.text = config!.generator.type;
      hoursController.text = config!.generator.totalHours.toString();
      invoiceController.text = config!.generator.electricityInvoice.toString();
      oilPriceController.text = config!.generator.oilPrice.toString();
      maintenanceController.text = config!.generator.maintenanceCost.toString();
      oilChangeController.text = config!.generator.oilChange.toString();
      filterCostController.text = config!.generator.filtersCost.toString();

      emit(AppConfigSuccess());
    } catch (e) {
      emit(AppConfigFailure('حدث خطأ أثناء تحميل بيانات التهيئة: $e'));
    }
  }

  Future<void> updateAppConfigGenerator({
    required String name,
    required String type,
    required double hours,
    required double invoice,
    required double oilPrice,
    required double maintenance,
    required double oilChange,
    required double filters,
  }) async {
    emit(AppConfigUpdateCalculationLoading());
    try {
      await _firebaseService.updateGenerator(
        generatorData: {
          'generatorName': name,
          'generatorType': type,
          'generatorTotalHours': hours,
          'generatorElectricityInvoice': invoice,
          'generatorOilPrice': oilPrice,
          'generatorMaintenanceCost': maintenance,
          'generatorOilChangeCost': oilChange,
          'generatorFilterCost': filters,
        },
      );
      emit(AppConfigUpdateCalculationSuccess());
      await fetchAppConfig();
    } catch (e) {
      emit(AppConfigUpdateCalculationFailure('فشل في تحديث بيانات المولد'));
    }
  }

  Future<void> updateAppConfigConstantWorker({required double cost}) async {
    emit(AppConfigUpdateCalculationLoading());
    try {
      await _firebaseService.updateConstantWorker(data: {'cost': cost});
      emit(AppConfigUpdateCalculationSuccess());
      await fetchAppConfig();
    } catch (e) {
      emit(AppConfigUpdateCalculationFailure('فشل في تحديث بيانات المولد'));
    }
  }
}
