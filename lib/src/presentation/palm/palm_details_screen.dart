import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_project/core/cubits/auth/auth_cubit.dart';
import 'package:farm_project/core/cubits/palms/palm_cubit.dart';
import 'package:farm_project/src/presentation/palm/edit_palm_screen.dart';
import 'package:flutter/material.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PalmDetailsScreen extends StatelessWidget {
  final PalmModel palm;
  final SegmentModel segment;
  final SectorModel sector;

  const PalmDetailsScreen({
    super.key,
    required this.palm,
    required this.segment,
    required this.sector,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل النخلة'),
        actions: [
         if(AuthCubit().isAdmin) IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: PalmCubit(),
                      child: Builder(
                        builder: (context) {
                          return EditPalmScreen(
                            palm: palm,
                            sector: sector,
                            segment: segment,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(theme, 'القطاع', sector.name),
                    _buildHeader(theme, 'القطعة', segment.name),
                  ],
                ),
                  PalmImage(imageUrl: palm.image??''),
                const SizedBox(height: 16),
                _buildDetail(
                  theme,
                  'نخلة رقم',
                  '(${palm.coordX}/ ${palm.coordY})',
                ),
                _buildDetail(theme, 'رسوم المياه', '${palm.waterCharge}'),
                _buildDetail(theme, 'رسوم السماد', '${palm.fertilizeCharge}'),
                _buildDetail(theme, 'رسوم المقاول', '${palm.contractorCharge}'),
                _buildDetail(
                  theme,
                  'رسوم الكهرباء',
                  '${palm.electricityCharge}',
                ),
                _buildDetail(theme, 'رسوم الري', '${palm.irrigateCharge}'),
                _buildDetail(theme, 'رسوم الأرض', '${palm.landCharge}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8),
      alignment: AlignmentDirectional.center,
      child: Text(
        '$label: $value',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildDetail(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PalmImage extends StatelessWidget {
  final String imageUrl;
  const PalmImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.hardEdge,
          child: Center(
            child: CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.fill,
            alignment: Alignment.center,
            errorWidget: (context, url, error) {
              return Icon(Icons.image);
            },
            width: 200,height: 200),
          ),
        ),
      ],
    );
  }
}