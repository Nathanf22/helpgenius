import 'package:helpgenius/model/agent_model.dart';
import 'package:helpgenius/views/agent_view.dart';

class AgentViewModel {
  Future<bool> addAgent(agentName, agentDescription) async{
    // String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
    // Map<String, String> headers = {
    //     "Authorization": "Bearer $accessToken"
    // };
    try {
      int agentID  = await AgentModel().addAgent(agentName);
      if(agentID == -1) return false;
      await AgentModel().addAgentDescription(agentDescription, agentID);
      return true;
      }
      catch(e){
        return false;
      }
  }

  Future<bool> removeAgent(agentID) async{
    // String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjk2MzU5MTE0fQ.S4TTi78X1ZQ-VyDYdRzT5Ybm14-MV59wxM7qn0MVNyc";
    // Map<String, String> headers = {
    //     "Authorization": "Bearer $accessToken"
    // };
    return await AgentModel().deleteAgent(agentID);
  }

  Future<List<Agent>> getAgentsList() async{
    return await AgentModel().getAgentsList();
  }

}