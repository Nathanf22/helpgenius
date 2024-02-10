import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:helpgenius/model/data.dart';
import 'package:helpgenius/model/link_model.dart';
import 'package:helpgenius/views/components/file_item.dart';
import 'package:helpgenius/viewsModel/agent_view_model.dart';
import 'package:helpgenius/viewsModel/file_view_model.dart';
import 'package:helpgenius/viewsModel/link_view_model.dart';
import 'package:helpgenius/viewsModel/text_view_model.dart';

class HomeViewModel {
  // List<File> files = [];

  // Méthode pour ajouter un fichier à la liste
  Future<bool> addFile({required String name, required Uint8List? bytes, int? size, String? extension, required int agentID}) async{
    return await uploadFile(name, bytes, agentID);
    // print(name);
    // // files.add(file);
    // // String filename = name;
    // // String extension = extension;
    // // String? size = size;
    // filesModel.add({
    //   'fileName' : name.split('.')[0],
    //   'fileSize': '${(size!/(1024*1024)).toStringAsFixed(2)} MB' ,
    //   'fileExtension': extension?? 'unknown'
    // });
    // print(filesModel);
    
  }
  // void addFiles(List<File> files){
  //   print('satrting here');
  //   for(int i=0; i< files.length; i++){
  //     addFile(files[i]);
  //   }
  //   // print(filesModel);
  // }

  // Méthode pour supprimer un fichier de la liste
  Future<String> removeFile(name, agentID) async {
    try {
      if(await deleteFile(name, agentID)){
        return 'success';
      }
      else{
        return 'error';
      }
      // filesModel.removeWhere((file) => file["fileName"] == name);
      // return 'success';
    }
    catch(e){
       return 'error: $e';
    }
    // files.remove(file);
  }

  Future<List<FileItem>> getFiles(int agentID)async {
    return loadFilesData(agentID);
  }

  Future<List<String>> getAgentsNames() async{
    dynamic listAgent = await AgentViewModel().getAgentsList();
    List<String> agentsNames = [];
    print(listAgent);
    listAgent.forEach((agent){
      int id = agent.id as int;
      agentsNames.add("$id:${agent.name}");
    });
    print("ended");
    return agentsNames;
  }


  Future<bool> newLink(agentID, link) async{
    return await addLink(agentID, link);
  }

  Future<bool> removeLink(int agentID, int linkID) async{
    return await deleteLink(agentID, linkID);
  }

  Future<List<Link>> getLinkList(int agentID) async{
    return await getLinks(agentID);
  }

Future<bool> putText(int agentID, String newText) async{
  return await updateText(agentID, newText);
}

Future<String> getTheText(int agentID) async{
  return await getText(agentID);
}


}
