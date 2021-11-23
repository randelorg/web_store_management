import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import '../Models/Admin_model.dart';

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
      Uint8List? uploadfile = result.files.single.bytes;
      //set the image to the setter
      image = uploadfile;

      //returns the file name
      return result.files.single.name.toString();
    }

    return 'No';
  }

  //returns the bytes of the image
  Future<Uint8List> getImage() async {
    return image;
  }
}
