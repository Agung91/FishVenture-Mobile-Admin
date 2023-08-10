import 'package:admin/common/custom/file_picker/model_upload_file.dart';

abstract class UploadFileService {
  Future<FileModel> sendFile(
      {required String path, Function(int, int)? progress});
}
