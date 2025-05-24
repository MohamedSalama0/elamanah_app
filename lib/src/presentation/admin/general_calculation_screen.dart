import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_constant_worker_screen.dart';
import 'package:farm_project/src/presentation/admin/edit/edit_generator_screen.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralCalculationScreen extends StatelessWidget {

  const GeneralCalculationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل حسابات ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            calculationItem(
              context,
              'تفاصيل المولد',
              const EditGeneratorScreen(),
            ), // Add this
            calculationItem(
              context,
              'تفاصيل العمالة الثابته',
              const EditConstantWorkerScreen(),
            ), // Add this
           
            
          ],
        ),
      ),
    );
  }

  Widget calculationItem(BuildContext context, String text, Widget widget) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: DefaultButton(
        fontSize: 23,
        
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
