import 'dart:convert';

import 'package:requests/requests.dart';

class FileModel {
  final String baseUrl;
  final Map<String, String> headers;

  FileModel({required this.baseUrl, required this.headers});

  // Méthode pour uploader un fichier sur le serveur
  // Future<void> uploadFile(String filePath) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/uploadfiles'), // Remplacez par l'URL d'upload de votre API
  //       headers: headers,
  //       body: {'file_path': filePath},
  //     );

  //     if (response.statusCode == 200) {
  //       print('Fichier uploadé avec succès.');
  //     } else {
  //       print('Échec de l\'upload du fichier. Code de réponse : ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Erreur lors de l\'upload du fichier : $e');
  //   }
  // }

  // Méthode pour récupérer la liste des fichiers depuis le serveur
  Future<List<String>> getFilesList() async{
    try {
      print('try to get files');
      dynamic response = await Requests.get(
        'http://localhost:8000/files/', // Remplacez par l'URL de récupération de la liste des fichiers de votre API
        // headers: headers,
      );
      print('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.json();
        print('body: $jsonResponse');
        final fileList = jsonResponse.get('files');
        print('fileList: $fileList');
         print('request ended');
        return fileList.cast<String>();
      } else {
        print('Échec de la récupération de la liste des fichiers. Code de réponse : ${response.statusCode}');
        print('request ended 1');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération de la liste des fichiers : $e');
      return [];
    }
  }

//   // Méthode pour récupérer les informations sur un fichier depuis le serveur
//   Future<Map<String, dynamic>> getFileInfo(String fileName) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/files/$fileName'), // Remplacez par l'URL de récupération d'informations sur un fichier de votre API
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print('Échec de la récupération des informations sur le fichier. Code de réponse : ${response.statusCode}');
//         return {};
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération des informations sur le fichier : $e');
//       return {};
//     }
//   }
}