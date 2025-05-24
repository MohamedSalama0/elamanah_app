import 'package:farm_project/core/cubits/app/app_config_cubit.dart';
import 'package:flutter/material.dart';

class EditConstantWorkerScreen extends StatefulWidget {
  const EditConstantWorkerScreen({super.key});

  @override
  State<EditConstantWorkerScreen> createState() => _EditConstantWorkerScreenState();
}

class _EditConstantWorkerScreenState extends State<EditConstantWorkerScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppConfigCubit();

    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل العمالة الثابته')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(cubit.constantWorkerPriceController, 'تكاليف العمالة الثابته'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await cubit.updateAppConfigConstantWorker(
                      cost: double.tryParse(cubit.constantWorkerPriceController.text)??0,
                    
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
