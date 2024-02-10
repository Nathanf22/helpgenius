import 'package:helpgenius/model/message_model.dart';
import 'package:helpgenius/viewsModel/agent_view_model.dart';

class TestViewModel{
  String userID = "sikatinathan@gmail.com"; 
  Future<ChatMessage> sendMessage(int agentID, String message) async{
    return await MessageModel().sendMessage(agentID, userID, message);
  }

  Future<List<ChatMessage>> getHistory(int agentID) async{
    return await MessageModel().getHistory(agentID, userID);
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


}