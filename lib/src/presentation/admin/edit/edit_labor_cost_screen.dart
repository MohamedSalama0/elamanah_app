import 'package:flutter/material.dart';
import 'package:farm_project/core/cubits/segments/segment_cubit.dart';

class EditLaborCostsScreen extends StatefulWidget {
  const EditLaborCostsScreen({super.key});

  @override
  State<EditLaborCostsScreen> createState() => _EditLaborCostsScreenState();
}

class _EditLaborCostsScreenState extends State<EditLaborCostsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fertilizingController;
  late TextEditingController _fertilizingHoursController;
  late TextEditingController _landWorkController;
  late TextEditingController _contractorController;

  @override
  void initState() {
    super.initState();
    final segment = SegmentCubit().selectedSegment!;
    _fertilizingController = TextEditingController(
      text: segment.fertilizingPrice.toString(),
    );
    _landWorkController = TextEditingController(
      text: segment.landWorkPrice.toString(),
    );
    _fertilizingHoursController = TextEditingController(
      text: segment.fertlizingHours.toString(),
    );
    _contractorController = TextEditingController(
      text: segment.contractorPersonsCost.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل تكاليف العمالة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(_fertilizingController, 'تكلفة التسميد'),
              _buildField(_fertilizingHoursController, 'عدد ساعات التسميد'),
              _buildField(_landWorkController, 'تكلفة خدمة الأرض'),
              _buildField(_contractorController, 'تكلفة مقاولين الأفراد'),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('حفظ')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) return 'برجاء إدخال $label';
          if (double.tryParse(value) == null) return 'برجاء إدخال رقم صحيح';
          return null;
        },
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      SegmentCubit().updateLaborCosts(
        fertilizingCost: double.parse(_fertilizingController.text),
        landWorkCost: double.parse(_landWorkController.text),
        fertlizingHours: int.parse(_fertilizingHoursController.text),
        contractorCost: double.parse(_contractorController.text),
      );
      Navigator.pop(context);
    }
  }
}
