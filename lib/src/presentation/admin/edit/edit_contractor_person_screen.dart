import 'package:flutter/material.dart';
import 'package:farm_project/core/cubits/segments/segment_cubit.dart';

class EditContractorPersonCostScreen extends StatefulWidget {
  const EditContractorPersonCostScreen({super.key});

  @override
  State<EditContractorPersonCostScreen> createState() => _EditContractorPersonCostScreenState();
}

class _EditContractorPersonCostScreenState extends State<EditContractorPersonCostScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    final segment = SegmentCubit().selectedSegment!;
    _costController = TextEditingController(text: segment.contractorPersonsCost.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تكلفة مقاولين الأفراد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _costController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'التكلفة'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'برجاء إدخال التكلفة';
                  if (double.tryParse(value) == null) return 'برجاء إدخال رقم صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCost = double.parse(_costController.text);
                    SegmentCubit().updateContractorPersonCost(newCost);
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
