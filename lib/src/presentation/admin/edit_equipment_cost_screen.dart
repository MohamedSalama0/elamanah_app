import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:flutter/material.dart';

class EditEquipmentCostScreen extends StatefulWidget {
  const EditEquipmentCostScreen({super.key});

  @override
  State<EditEquipmentCostScreen> createState() =>
      _EditEquipmentCostScreenState();
}

class _EditEquipmentCostScreenState extends State<EditEquipmentCostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _equipmentCostController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final segment = SegmentCubit().selectedSegment;
    if (segment != null) {
      _equipmentCostController.text = segment.equipmentUsedCost.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SegmentCubit();
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل تكلفة المعدات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _equipmentCostController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'تكلفة المعدات'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل قيمة تكلفة المعدات';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newCost = double.parse(_equipmentCostController.text);
                    await cubit.updateSegmentEquipmentCost(
                      newEquipmentCost: newCost,
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
}
