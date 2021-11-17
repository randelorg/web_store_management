import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class Picker {
  Future<Uint8List?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      Uint8List? uploadfile = result.files.single.bytes;
      return uploadfile;
    }

    return null;
  }
}
