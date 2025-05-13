import 'package:farm_project/core/cubits/segments/segment_cubit.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/src/presentation/farm/palms_screen.dart';
import 'package:farm_project/src/widgets/square_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentsScreen extends StatefulWidget {
  final SectorModel sector;
  const SegmentsScreen({super.key, required this.sector});

  @override
  State<SegmentsScreen> createState() => _SegmentsScreenState();
}

class _SegmentsScreenState extends State<SegmentsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SegmentCubit()..fetchSegments(widget.sector.id),

      child: Builder(
        builder: (context) {
          return BlocConsumer<SegmentCubit, SegmentState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = SegmentCubit();
              final segments = cubit.segments;
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.sector.name),
                  centerTitle: true,
                ),
                body: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: segments.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final segment = segments[index];
                    return SquareCard(
                      title: segment.name,
                      gridSize: '',
                      //'${segment.horizontalPalms} x ${segment.verticalPalms}',
                      onTap: () {
                        SegmentCubit().setInitialSegment(widget.sector, segment);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider.value(
                                  value: SegmentCubit(),
                                  child: PalmsScreen(
                                    sector: widget.sector,
                                    segment: segment,
                                  ),
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
