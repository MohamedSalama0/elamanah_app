import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_contractor_person_screen.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_generator_screen.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_irrigation_screen.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_labor_cost_screen.dart';
import 'package:farm_project/src/presentation/admin/edit_equipment_cost_screen.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentCalculationScreen extends StatelessWidget {
  final SegmentModel segment;
  final SectorModel sector;
  const SegmentCalculationScreen({
    super.key,
    required this.segment,
    required this.sector,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل حسابات القطعة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            calculationItem(context, 'إعدادات الري', EditIrrigationScreen()),
            calculationItem(
              context,
              'تكلفة المعدات',
              EditEquipmentCostScreen(),
            ),
            calculationItem(
              context,
              'تفاصيل المولد',
              const EditGeneratorScreen(),
            ), // Add this
            calculationItem(
              context,
              'تكلفة مقاولين الأفراد',
              const EditContractorPersonCostScreen(),
            ),
            calculationItem(
              context,
              'تكاليف العمالة (تسميد - خدمة الارض - مقاول)',
              const EditLaborCostsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget calculationItem(BuildContext context, String text, Widget widget) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: DefaultButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(value: SegmentCubit(), child: widget),
            ),
          );
        },
        text: text,
      ),
    );
  }
}
