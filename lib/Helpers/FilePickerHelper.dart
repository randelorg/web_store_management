import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class Picker {
  //holds the bytes of the image
  var _image;

  get image => this._image;

  set image(var value) => this._image = value;

  Future<String> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );

    if (result != null) {
      image = result.files.single.bytes;

      return result.files.single.name.toString();
    }

    return 'No file is selected';
  }

  Uint8List getImageBytes() {
    return image;
  }
}
