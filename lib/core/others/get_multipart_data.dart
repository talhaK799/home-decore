import 'dart:io';
import 'package:dio/dio.dart' as dio;

getMultiPartFile(File image) async {
  return {'profile': await dio.MultipartFile.fromFile(image.path)};
}
