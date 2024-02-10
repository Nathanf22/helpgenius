import 'package:helpgenius/model/text_model.dart';

Future<bool> updateText(int agentID, String newText) async{
  return await TextModel().updateText(agentID, newText);
}

Future<String> getText(int agentID) async{
  return await TextModel().getText(agentID);
}