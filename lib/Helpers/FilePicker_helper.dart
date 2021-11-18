import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import '../Models/Admin_model.dart';

class Picker {
  var image = Admin.empty();

  Future<String> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );

    if (result != null) {
      Uint8List? uploadfile = result.files.single.bytes;
      image.setUserImage = uploadfile;
      return result.files.single.name.toString();
    }

    return 'No';
  }
}
