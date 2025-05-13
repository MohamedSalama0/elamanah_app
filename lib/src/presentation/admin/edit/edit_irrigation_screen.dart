import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:flutter/material.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/irrigation_model.dart';

class EditIrrigationScreen extends StatefulWidget {
  const EditIrrigationScreen({super.key});

  @override
  State<EditIrrigationScreen> createState() => _EditIrrigationScreenState();
}

class _EditIrrigationScreenState extends State<EditIrrigationScreen> {
  List<IrrigationModel> irrigationItems = [];

  late SegmentModel segment;
  late SectorModel sector;
  late double irrigationTransportCost;

  @override
  void initState() {
    super.initState();
    segment = SegmentCubit().selectedSegment!;
    irrigationTransportCost = segment.irrigationTransportCost;
    sector = SegmentCubit().selectedSector!;
    // Clone the irrigation list from segment
    irrigationItems =
        segment.irrigationItems
            .map(
              (e) => IrrigationModel(
                pipeSize: e.pipeSize,
                segmentId: e.segmentId,
                length: e.length,
                width: e.width,
                price: e.price,
                count: e.count,
              ),
            )
            .toList();
  }

  void addItem() {
    setState(() {
      irrigationItems.add(
        IrrigationModel(
          pipeSize: 0,
          segmentId: segment.id,
          length: 0,
          width: 0,
          price: 0,
          count: 0,
        ),
      );
    });
  }

  void removeItem(int index) {
    setState(() {
      irrigationItems.removeAt(index);
    });
  }

  void saveIrrigationData() async {
    final segmentCubit = SegmentCubit();

    await segmentCubit.updateSegmentIrrigation(
      sectorId: sector.id, // make sure sectorId exists
      segment: segment,
      irrigationList: irrigationItems,
      irrigationTransportCost: irrigationTransportCost,
    );

    if (context.mounted) {
      Navigator.pop(context); // back after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الري')),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: irrigationItems.length,
        itemBuilder: (context, index) {
          final item = irrigationItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('عنصر ${index + 1}'),
                  _buildTextField(
                    label: 'حجم الأنبوب',
                    initialValue: item.pipeSize.toString(),
                    onChanged: (v) => item.pipeSize = double.tryParse(v) ?? 0.0,
                  ),
                  _buildTextField(
                    label: 'الطول',
                    initialValue: item.length.toString(),
                    onChanged: (v) => item.length = double.tryParse(v) ?? 0.0,
                  ),
                  _buildTextField(
                    label: 'العرض',
                    initialValue: item.width.toString(),
                    onChanged: (v) => item.width = double.tryParse(v) ?? 0.0,
                  ),
                  _buildTextField(
                    label: 'السعر',
                    initialValue: item.price.toString(),
                    onChanged: (v) => item.price = double.tryParse(v) ?? 0.0,
                  ),
                  _buildTextField(
                    label: 'العدد',
                    initialValue: item.count.toString(),
                    onChanged: (v) => item.count = int.tryParse(v) ?? 0,
                  ),
                  Text('إجمالي السعر: ${item.count * item.price}'),
                  ElevatedButton(
                    onPressed: () => removeItem(index),
                    child: const Text('حذف'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إجمالي مصنعية الري: '),
                _buildTextField(
                  label: 'سعر نقل شبكة الصرف: ',
                  initialValue: segment.irrigationTransportCost.toString(),
                  onChanged:
                      (v) => irrigationTransportCost = double.tryParse(v) ?? 0,
                ),
                Text('إجمالي تكلفة شبكة الري للقطعة: ${calculateTotal()}'),
              ],
            ),
            ElevatedButton(
              onPressed: saveIrrigationData,
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotal() {
    return irrigationTransportCost +
        0
        /**for مصنعية */
        +
        irrigationItems
            .map((item) => item.count * item.price)
            .reduce((a, b) => a + b);
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required void Function(String) onChanged,
  }) {
    final controller = TextEditingController(text: initialValue);
    return TextField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: (str) {
        onChanged(str);
      },
      onEditingComplete: () {
        setState(() {});
      },
    );
  }
}
