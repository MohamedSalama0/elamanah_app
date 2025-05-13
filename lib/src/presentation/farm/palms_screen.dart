import 'package:farm_project/core/cubits/auth/auth_cubit.dart';
import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:farm_project/core/services/dummy_data_uploader_service.dart';
import 'package:farm_project/core/utils/router.dart';
import 'package:farm_project/src/presentation/admin/segment_calculation_screen.dart';
import 'package:farm_project/src/presentation/palm/palm_details_screen.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farm_project/core/cubits/palms/palm_cubit.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';

class PalmsScreen extends StatefulWidget {
  final SegmentModel segment;
  final SectorModel sector;
  const PalmsScreen({super.key, required this.segment, required this.sector});

  @override
  State<PalmsScreen> createState() => _PalmsScreenState();
}

class _PalmsScreenState extends State<PalmsScreen> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              PalmCubit()..fetchPalms(widget.sector.id, widget.segment.id),
      child: Builder(
        builder: (context) {
          return BlocConsumer<PalmCubit, PalmState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = PalmCubit();
              final palms = cubit.palms;
              if (palms.isEmpty)
                return Material(
                  child: Center(child: CircularProgressIndicator()),
                );

              final int horizontalPalms = cubit.maxHorizontalPalms;
              final int verticalPalms = cubit.maxVerticalPalms;

              final double minPalmSize = 150; // minimum box size

              final double totalWidth = horizontalPalms * minPalmSize * _scale;
              final double totalHeight = verticalPalms * minPalmSize * _scale;

              return Scaffold(
                appBar: AppBar(title: Text('النخل'), centerTitle: true),
                body: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'قطاع : ${SegmentCubit().selectedSector!.name}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'قطعة : ${widget.segment.name}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '$horizontalPalms نخلة * $verticalPalms خط',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    Expanded(
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 5.0,
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        onInteractionUpdate: (details) {
                          setState(() {
                            _scale = details.scale;
                          });
                        },
                        child: SizedBox(
                          width: totalWidth,
                          height: totalHeight,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: horizontalPalms,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: 1,
                                ),
                            itemCount: palms.length,
                            itemBuilder: (context, index) {
                              final palm = palms[index];
                              return PalmCard(
                                coordX: palm.coordX,
                                coordY: palm.coordY,
                                scale: _scale,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => PalmDetailsScreen(
                                            palm: palm,
                                            segment: widget.segment,
                                            sector: widget.sector,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                   if(AuthCubit().isAdmin) Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultButton(
                        onTap: () {
                          push(
                            context,
                            BlocProvider.value(
                              value: SegmentCubit(),
                              child: SegmentCalculationScreen(
                                segment: widget.segment,
                                sector: widget.sector,
                              ),
                            ),
                          );
                        },
                        text: 'تعديل حسابات القطعة',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PalmCard extends StatelessWidget {
  final int coordX;
  final int coordY;
  final VoidCallback onTap;
  final double scale;

  const PalmCard({
    super.key,
    required this.coordX,
    required this.coordY,
    required this.onTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 12 * scale;
    if (fontSize < 8) fontSize = 8; // minimum font
    if (fontSize > 24) fontSize = 24; // maximum font

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Theme.of(context).colorScheme.primary.withAlpha(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        child: Center(
          child: Text(
            '$coordX, $coordY',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
