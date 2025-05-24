import 'package:farm_project/core/cubits/app/app_config_cubit.dart';
import 'package:flutter/material.dart';

class EditGeneratorScreen extends StatefulWidget {
  const EditGeneratorScreen({super.key});

  @override
  State<EditGeneratorScreen> createState() => _EditGeneratorScreenState();
}

class _EditGeneratorScreenState extends State<EditGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppConfigCubit();

    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المولد')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(cubit.nameController, 'اسم المولد'),
              _buildField(cubit.typeController, 'نوع المولد'),
              _buildField(cubit.hoursController, 'عدد ساعات التشغيل', isNumber: true),
              _buildField(cubit.invoiceController, 'فاتورة الكهرباء', isNumber: true),
              _buildField(cubit.oilPriceController, 'سعر السولار', isNumber: true),
              _buildField(cubit.maintenanceController, 'تكلفة الصيانة', isNumber: true),
              _buildField(cubit.oilChangeController, 'تكلفة تغيير الزيت', isNumber: true),
              _buildField(cubit.filterCostController, 'تكلفة الفلاتر', isNumber: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await cubit.updateAppConfigGenerator(
                      name: cubit.nameController.text,
                      type: cubit.typeController.text,
                      hours: double.tryParse(cubit.hoursController.text) ?? 0,
                      invoice: double.tryParse(cubit.invoiceController.text) ?? 0,
                      oilPrice: double.tryParse(cubit.oilPriceController.text) ?? 0,
                      maintenance: double.tryParse(cubit.maintenanceController.text) ?? 0,
                      oilChange: double.tryParse(cubit.oilChangeController.text) ?? 0,
                      filters: double.tryParse(cubit.filterCostController.text) ?? 0,
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
