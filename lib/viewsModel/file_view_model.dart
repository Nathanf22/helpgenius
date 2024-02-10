import 'dart:convert';

import 'package:helpgenius/model/data.dart';
import 'package:helpgenius/model/file_model.dart';
import 'package:helpgenius/views/components/file_item.dart';

import '../model/global_params.dart';

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


Future<List<FileItem>> loadFilesData(int agentID) async{
  String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
  Map<String, String> headers = {
      "Authorization": "Bearer $accessToken"
  };
  List<dynamic> remoteFiles = await FileModel(baseUrl: baseUrl, headers: headers, agentID: agentID).getFilesList();
  print('loading...');
  filesModel = transformFileList(remoteFiles);
  String jsonString = json.encode(filesModel);
  final List<FileItem> files = parseFiles(jsonString);
  print("files: $files");
  return files;
}

Future<bool> deleteFile(fileName, agentID) async{
  String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
  Map<String, String> headers = {
      "Authorization": "Bearer $accessToken"
  };
  return await FileModel(baseUrl: baseUrl, headers: headers, agentID: agentID).deleteFile(fileName);
}

Future<bool> uploadFile(filename, file, agentID) async{
   String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
  Map<String, String> headers = {
      "Authorization": "Bearer $accessToken"
  };
   return await FileModel(baseUrl: baseUrl, headers: headers, agentID: agentID).uploadFile(filename, file);
} 

List<Map<String, String>> transformFileList(List<dynamic> inputFiles) {
  List<Map<String, String>> filesModel = [];

  for (int i = 0; i < inputFiles.length; i++) {
    String fileName = inputFiles[i]['name'].toString();
    String fileSize = calculateFileSize(inputFiles[i]['size']);
    String fileExtension = inputFiles[i]['format'].toString();

    Map<String, String> fileModel = {
      "fileName": fileName,
      "fileSize": fileSize,
      "fileExtension": fileExtension,
    };

    filesModel.add(fileModel);
  }

  return filesModel;
}

String calculateFileSize(int sizeInBytes) {
  const int kbSize = 1024;
  const int mbSize = kbSize * 1024;

  if (sizeInBytes >= mbSize) {
    double sizeInMB = sizeInBytes / mbSize;
    return "${sizeInMB.toStringAsFixed(1)} MB";
  } else if (sizeInBytes >= kbSize) {
    double sizeInKB = sizeInBytes / kbSize;
    return "${sizeInKB.toStringAsFixed(1)} KB";
  } else {
    return "$sizeInBytes Bytes";
  }
}