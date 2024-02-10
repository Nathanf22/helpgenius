import 'dart:convert';

import 'package:helpgenius/model/global_params.dart';
import 'package:helpgenius/views/agent_view.dart';
import 'package:requests/requests.dart';

class AgentModel {

  Future<int> addAgent(name) async{
    try {
      dynamic response = await Requests.post("$baseUrl/agents/$name");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          int agentID = jsonResponse['agent_id'];
          return agentID;
        }
        else{
          return -1;
        }
    }
    catch (e){
      print("erreur lors de la creation de l'agent: $e");
      return -1;
    }
  }

  Future<bool> addAgentDescription(description, agentID) async{
    try {
      dynamic response = await Requests.post("$baseUrl/agents/$agentID/description/$description");
        if (response.statusCode == 200){
          return true;
        }
        else{
          return false;
        }
    }
    catch (e){
      print("erreur lors de l'ajout de la description de l'agent: $e");
      return false;
    }
  }

  Future<List<Agent>> getAgentsList() async{
    try {
      dynamic response = await Requests.get("$baseUrl/agents");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          print(jsonResponse);
          List<dynamic> list = jsonResponse['agent_list'];
          List<Agent>agentList = [];
          list.forEach((element) {
            // element = jsonDecode(element as String);
            agentList.add(Agent(id: element['agent_id'] as int, name: element['agent_name'], description: element['agent_description'], ));
          });
          return agentList;
        }
        else{
          return [];
        }
    }
    catch (e){
      print("erreur lors de la recuperation de la liste des agents: $e");
      return [];
    }
  }

  Future<Agent> getAgentInfo(agentID) async{
    try{
      dynamic response = await Requests.get("$baseUrl/agents/$agentID");
      if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          String name = jsonResponse['agent_name'];
          String description = jsonResponse['agent_description'];
          return Agent(id: agentID, name: name, description: description);
        }
        else{
          return Agent(id: -1 , description: "", name: "");
        }

    }
    catch(e){
      print("Erreur lors de la recuperation des infos de l'agent $agentID: $e");
      return Agent(id: -1, description: "", name: "");
    }
    
  }


  Future<bool> deleteAgent(agentID) async{
    try{
      dynamic response = await Requests.delete("$baseUrl/agents/$agentID");
      if (response.statusCode == 200){
          // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          return true;
      }
        else{
          return false;
        }

    }
    catch (e){
       print("Erreur lors de la supression de l'agent $agentID: $e");
       return false;
    }
  }
}
