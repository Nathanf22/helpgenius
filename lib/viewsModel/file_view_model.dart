import 'dart:convert';

import 'package:helpgenius/model/data.dart';
import 'package:helpgenius/model/file_model.dart';
import 'package:helpgenius/views/components/file_item.dart';

List<FileItem> parseFiles(String jsonStr) {
  final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
  return parsed.map<FileItem>((json) {
    // print(json['fileName']);
    return FileItem(
    fileName: json['fileName'] as String,
    fileSize: json['fileSize'] as String,
    fileExtension: json['fileExtension'] as String,
  );
  }
    ).toList();
}

// String jsonString = """[
//   {
//     "fileName": "MonFichier1",
//     "fileSize": "1.2 MB",
//     "fileExtension": "pdf"
//   },
//   {
//     "fileName": "MonFichier2",
//     "fileSize": "0.8 MB",
//     "fileExtension": "docx"
//   },
//   {
//     "fileName": "MonFichier3",
//     "fileSize": "2.0 MB",
//     "fileExtension": "xlsx"
//   }
// ]""";


Future<List<FileItem>> loadFilesData() async{
  String baseUrl = 'http://localhost:8000';
  String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
  Map<String, String> headers = {
      "Authorization": "Bearer $accessToken"
  };
  List<String>remoteFiles = await FileModel(baseUrl: baseUrl, headers: headers).getFilesList();
  print('loading...');
  String jsonString = json.encode(filesModel);
  final List<FileItem> files = parseFiles(jsonString);
  print("files: $files");
  return files;
}

