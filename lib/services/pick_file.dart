import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/controllers/file_controller.dart';

Future pickFile() async {
  FileController fileController = Get.put(FileController());
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  fileController.file.value = result!.files.first;

}