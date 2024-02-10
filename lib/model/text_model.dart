import 'dart:convert';

import 'package:requests/requests.dart';

import 'global_params.dart';

class TextModel {
    Future<bool> updateText(int agentID, String newText) async{
    try {
      dynamic response = await Requests.put("$baseUrl/agents/$agentID/text", body: {"text": newText});
        if (response.statusCode == 200){
          return true;
        }
        else{
          return false;
        }
    }
    catch (e){
      print("erreur lors de la mise a jour du texte': $e");
      return false;
    }
  }

    Future<String> getText(agentID) async{
    try {
      dynamic response = await Requests.get("$baseUrl/agents/$agentID/text");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          String text = jsonResponse['text'];
          
          return text;
        }
        else{
          return "";
        }
    }
    catch (e){
      print("erreur lors de la recuperation de du text: $e");
      return "";
    }
  }

}
