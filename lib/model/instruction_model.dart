import 'dart:convert';

import 'package:requests/requests.dart';

import 'global_params.dart';

class InstructionModel {
    Future<bool> updateInstruction(agentID, newInstruction) async{
    try {
      dynamic response = await Requests.put("$baseUrl/agents/$agentID/instruction", body: {"instruction_text": newInstruction});
        if (response.statusCode == 200){
          return true;
        }
        else{
          return false;
        }
    }
    catch (e){
      print("erreur lors de la mise a jour de l'instruction': $e");
      return false;
    }
  }

    Future<String> getInstruction(agentID) async{
    try {
      dynamic response = await Requests.get("$baseUrl/agents/$agentID/instruction");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          String instruction = jsonResponse['nstruction_text'];
          
          return instruction;
        }
        else{
          return "";
        }
    }
    catch (e){
      print("erreur lors de la recuperation de l'instruction': $e");
      return "";
    }
  }

}
