import 'dart:convert';

import 'package:helpgenius/model/global_params.dart';
import 'package:helpgenius/viewsModel/link_view_model.dart';
import 'package:requests/requests.dart';

class LinkModel{
  Future<int> addLink(agentID, link) async{
    try {
      dynamic response = await Requests.post("$baseUrl/agents/$agentID/link", body: {'link': link});
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          int linkID = jsonResponse['link_id'];
          return linkID;
        }
        else{
          return -1;
        }
    }
    catch (e){
      print("erreur lors de l'ajout du lien': $e");
      return -1;
    }
  }

  Future<List<Link>> getLinkList(int agentID) async{
    try {
      dynamic response = await Requests.get("$baseUrl/agents/$agentID/link_list");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          List<dynamic> list = jsonResponse['link_list'];
          // print("link_list: $list");
          List<Link>linkList = [];
          for (var element in list) {
            if (element['link'] != null){
              linkList.add(Link(element['link'], element['link_id'] as int));
            }
            // element = jsonDecode(element as String);  
          }
          print("link_0 id: ${linkList[0].id}");
          return linkList;
        }
        else{
          return [];
        }
    }
    catch (e){
      print("erreur lors de la recuperation de la liste des liens: $e");
      return [];
    }
  }


    Future<bool> deleteLink(int agentID,int linkID) async{
    try{
      dynamic response = await Requests.delete("$baseUrl/agents/$agentID/link/$linkID");
      if (response.statusCode == 200){
          // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          return true;
      }
        else{
          return false;
        }

    }
    catch (e){
       print("Erreur lors de la supression du lien: $e");
       return false;
    }
  }
}


class Link {
  final String link;
  final int id;

  Link(this.link, this.id);
}