import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage({required ImageSource source}) async {
    PermissionStatus permissionStatus = await _getPermission(source);
    if (permissionStatus != PermissionStatus.granted) {
      return null;
    }

    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<PermissionStatus> _getPermission(ImageSource source) async {
    PermissionStatus permission;
    if (source == ImageSource.camera) {
      permission = await Permission.camera.status;
      if (permission != PermissionStatus.granted) {
        permission = await Permission.camera.request();
      }
    } else {
      permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        print('permission not granted');
        permission = await Permission.storage.request();
        print('permission is granted ${permission.isGranted}');
      }
    }
    return permission;
  }
}
