import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_project/core/cubits/palms/palm_cubit.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditPalmScreen extends StatefulWidget {
  final PalmModel palm;
  final SectorModel sector;
  final SegmentModel segment;

  const EditPalmScreen({
    super.key,
    required this.palm,
    required this.sector,
    required this.segment,
  });

  @override
  State<EditPalmScreen> createState() => _EditPalmScreenState();
}

class _EditPalmScreenState extends State<EditPalmScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController coordX;
  late final TextEditingController coordY;
  late final TextEditingController waterCharge;
  late final TextEditingController fertlizeCharge;
  late final TextEditingController contractorCharge;
  late final TextEditingController electricityCharge;
  late final TextEditingController irrigateCharge;
  late final TextEditingController landCharge;

  @override
  void initState() {
    super.initState();
    final palm = widget.palm;

    coordX = TextEditingController(text: palm.coordX.toString());
    coordY = TextEditingController(text: palm.coordY.toString());
    waterCharge = TextEditingController(text: palm.waterCharge.toString());
    fertlizeCharge = TextEditingController(
      text: palm.fertilizeCharge.toString(),
    );
    contractorCharge = TextEditingController(
      text: palm.contractorCharge.toString(),
    );
    electricityCharge = TextEditingController(
      text: palm.electricityCharge.toString(),
    );
    irrigateCharge = TextEditingController(
      text: palm.irrigateCharge.toString(),
    );
    landCharge = TextEditingController(text: palm.landCharge.toString());
  }

  @override
  void dispose() {
    coordX.dispose();
    coordY.dispose();
    waterCharge.dispose();
    fertlizeCharge.dispose();
    contractorCharge.dispose();
    electricityCharge.dispose();
    irrigateCharge.dispose();
    landCharge.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedPalm = widget.palm.copyWith(
        coordX: int.parse(coordX.text),
        coordY: int.parse(coordY.text),
        waterCharge: double.parse(waterCharge.text),
        fertlizeCharge: double.parse(fertlizeCharge.text),
        contractorCharge: double.parse(contractorCharge.text),
        electricityCharge: double.parse(electricityCharge.text),
        irrigateCharge: double.parse(irrigateCharge.text),
        landCharge: double.parse(landCharge.text),
      );
      PalmCubit().updatePalm(widget.sector.id, widget.segment.id, updatedPalm);
    }
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool isInt = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val == null || val.isEmpty) return 'Required';
        final numVal = isInt ? int.tryParse(val) : double.tryParse(val);
        return numVal == null ? 'Invalid number' : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Palm')),
      body: BlocConsumer<PalmCubit, PalmState>(
        listener: (BuildContext context, PalmState state) {
          if (state is PalmUpdateFailure) {
            SnackBarHelper.showMySnackbar(
              context,
              state.message,
              warning: true,
            );
          }
          if (state is PalmUpdateSuccess) {
            SnackBarHelper.showMySnackbar(context, 'تم تحيث البيانات بنجاح');
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  EditPalmImage(
                    imageUrl: widget.palm.image ?? '',
                    onTap: _pickAndUploadImage,
                  ),
                  // _field('Coordinate X', coordX, isInt: true),
                  // _field('Coordinate Y', coordY, isInt: true),
                  // _field('Water Charge', waterCharge),
                  
                //_field('الفسيلة', waterCharge),
                  
                  // _field('Fertilizer Charge', fertlizeCharge),
                  // _field('Contractor Charge', contractorCharge),
                  // _field('Electricity Charge', electricityCharge),
                  // _field('Irrigate Charge', irrigateCharge),
                  // _field('Land Charge', landCharge),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: _submit,
                  //   child: const Text('Save Changes'),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    ); // or .camera

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      PalmCubit().updatePalmImage(
        widget.sector.id,
        widget.segment.id,
        widget.palm,
        file,
      );
    }
  }
}

class EditPalmImage extends StatelessWidget {
  final String imageUrl;
  final void Function()? onTap;

  const EditPalmImage({super.key, required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: Center(
              child:
                  CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                         errorWidget: (context, url, error) {
              return Icon(Icons.image);
            },
                        width: 200,
                        height: 200,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
