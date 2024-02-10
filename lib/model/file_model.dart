import 'dart:convert';

import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;

class FileModel {
  final String baseUrl;
  final Map<String, String> headers;
  final int agentID;

  FileModel({required this.baseUrl, required this.headers, required this.agentID});

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
  Future<List<dynamic>> getFilesList() async{
    try {
      print('try to get files');
      dynamic response = await Requests.get(
        "$baseUrl/agents/$agentID/file_list", // Remplacez par l'URL de récupération de la liste des fichiers de votre API
        // headers: headers,
      );
      print('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('body: $jsonResponse');
        List<dynamic> fileList = jsonResponse['files'];
        print('fileList: $fileList');
         print('request ended');
        return fileList;
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

  Future<bool> uploadFile(filename, file) async{
   final url = Uri.parse("$baseUrl/agents/$agentID/upload");

  var request = http.MultipartRequest('POST', url)
    ..files.add( http.MultipartFile.fromBytes('file', file, filename: filename));

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Fichier téléchargé avec succès.');
      return true;      
    } else {
      print('Échec du téléchargement du fichier. Statut: ${response.statusCode}');
      return false;
    }
  } catch (error) {
    print('Erreur lors de l\'envoi du fichier: $error');
    return false;
  }
  }

  Future<bool> deleteFile(fileName) async{
    try {
       dynamic response = await Requests.delete(
        "$baseUrl/agents/$agentID/file/$fileName", 
        // headers: headers,
      );
      if(response.statusCode == 200){
        return true;
      }
      else{
        print("StatusCode: ${response.statusCode}");
        print("message: ${jsonDecode(response.body)['message']}");
        return false;
      }

    }

    catch (e){
      print('Erreur lors de la superssion: $e');
      return false;
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