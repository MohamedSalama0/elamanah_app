import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditGeneratorScreen extends StatefulWidget {
  const EditGeneratorScreen({super.key});

  @override
  State<EditGeneratorScreen> createState() => _EditGeneratorScreenState();
}

class _EditGeneratorScreenState extends State<EditGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final hoursController = TextEditingController();
  final invoiceController = TextEditingController();
  final oilPriceController = TextEditingController();
  final maintenanceController = TextEditingController();
  final oilChangeController = TextEditingController();
  final filterCostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final segment = SegmentCubit().selectedSegment!;
    nameController.text = segment.generatorName ;
    typeController.text = segment.generatorType ;
    hoursController.text = segment.generatorTotalHours.toString() ;
    invoiceController.text = segment.generatorElectricityInvoice.toString() ;
    oilPriceController.text = segment.generatorOilPrice.toString() ;
    maintenanceController.text = segment.generatorMaintenanceCost.toString() ;
    oilChangeController.text = segment.generatorOilChange.toString() ;
    filterCostController.text = segment.generatorFiltersCost.toString() ;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SegmentCubit();

    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المولد')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(nameController, 'اسم المولد'),
              _buildField(typeController, 'نوع المولد'),
              _buildField(hoursController, 'عدد ساعات التشغيل', isNumber: true),
              _buildField(invoiceController, 'فاتورة الكهرباء', isNumber: true),
              _buildField(oilPriceController, 'سعر الزيت', isNumber: true),
              _buildField(maintenanceController, 'تكلفة الصيانة', isNumber: true),
              _buildField(oilChangeController, 'تكلفة تغيير الزيت', isNumber: true),
              _buildField(filterCostController, 'تكلفة الفلاتر', isNumber: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await cubit.updateSegmentGenerator(
                      name: nameController.text,
                      type: typeController.text,
                      hours: double.tryParse(hoursController.text) ?? 0,
                      invoice: double.tryParse(invoiceController.text) ?? 0,
                      oilPrice: double.tryParse(oilPriceController.text) ?? 0,
                      maintenance: double.tryParse(maintenanceController.text) ?? 0,
                      oilChange: double.tryParse(oilChangeController.text) ?? 0,
                      filters: double.tryParse(filterCostController.text) ?? 0,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'من فضلك أدخل $label';
          }
          return null;
        },
      ),
    );
  }
}
