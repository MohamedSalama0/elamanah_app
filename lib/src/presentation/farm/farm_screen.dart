import 'package:farm_project/core/cubits/sector/sector_cubit.dart';
import 'package:farm_project/core/cubits/sector/sector_states.dart';
import 'package:farm_project/src/presentation/farm/segments_screen.dart';
import 'package:farm_project/src/widgets/square_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {

  @override
  void initState() {
    super.initState();
    SectorCubit().fetchSectors();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SectorCubit,SectorState>(
      listener: (oldState, newState) {},
      builder: (ctx, index) {
        final cubit = SectorCubit();
        final sectors = cubit.sectors;
        return GridView.builder(
          itemCount: sectors.length, // can be dynamic later
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final sector = sectors[index];
            return SquareCard(
              title: sector.name,
              gridSize: '',
              onTap: () {
                                       // DummyDataUploaderService().uploadDummyData();

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SegmentsScreen(sector: sector,)));
                // TODO: Navigate to Square Details Screen
              },
            );
          },
        );
      },
    );
  }
}
