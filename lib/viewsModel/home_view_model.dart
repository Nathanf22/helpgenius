import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:helpgenius/model/data.dart';
import 'package:helpgenius/views/components/file_item.dart';
import 'package:helpgenius/viewsModel/file_view_model.dart';

class HomeViewModel {
  // List<File> files = [];

  // Méthode pour ajouter un fichier à la liste
  void addFile({required String name, required Uint8List? bytes, int? size, String? extension}) {
    print(name);
    // files.add(file);
    // String filename = name;
    // String extension = extension;
    // String? size = size;
    filesModel.add({
      'fileName' : name.split('.')[0],
      'fileSize': '${(size!/(1024*1024)).toStringAsFixed(2)} MB' ,
      'fileExtension': extension?? 'unknown'
    });
    print(filesModel);
    
  }
  // void addFiles(List<File> files){
  //   print('satrting here');
  //   for(int i=0; i< files.length; i++){
  //     addFile(files[i]);
  //   }
  //   // print(filesModel);
  // }

  // Méthode pour supprimer un fichier de la liste
  String removeFile(name) {
    try {
      filesModel.removeWhere((file) => file["fileName"] == name);
      return 'success';
    }
    catch(e){
       return 'error: $e';
    }
    // files.remove(file);
  }

  Future<List<FileItem>> getFiles( )async {
    return loadFilesData();
  }
}
