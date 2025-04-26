import 'package:farm_project/src/presentation/palm/palms_screen.dart';
import 'package:farm_project/src/widgets/square_card.dart';
import 'package:flutter/material.dart';

class FarmScreen extends StatelessWidget {
  const FarmScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4, // can be dynamic later
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return SquareCard(
          title: 'قطاع ${index + 1}',
          gridSize: '32 × 31',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PalmsScreen()));
            // TODO: Navigate to Square Details Screen
          },
        );
      },
    );
  }
}
