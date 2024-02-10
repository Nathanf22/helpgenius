import 'dart:convert';

import 'package:requests/requests.dart';

import 'global_params.dart';

class ModelModel{
  Future<bool> setModel(agentID, modelID) async{
    try {
      dynamic response = await Requests.put("$baseUrl/agents/$agentID/model/$modelID");
        if (response.statusCode == 200){
          return true;
        }
        else{
          print("erreur lors du choix du model': ${response['message']}");
          return false;
        }
    }
    catch (e){
      print("erreur lors du choix du model': $e");
      return false;
    }
  }

  Future<List<Model>> getModelList() async{
    try {
      dynamic response = await Requests.get("$baseUrl/models");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          List<Map<String, dynamic>> list = jsonResponse['model_list'];
          List<Model>modelList = [];
          for (var element in list) {
            // element = jsonDecode(element as String);
            modelList.add(Model(element['model_id'] as int, element['model_name']));
          }
          return modelList;
        }
        else{
          return [];
        }
    }
    catch (e){
      print("erreur lors de la recuperation de la liste des models: $e");
      return [];
    }
  }
}

class Model {
  final int id;
  final String name;
  
  Model(this.id, this.name);
}