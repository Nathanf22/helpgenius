import 'package:helpgenius/model/link_model.dart';

Future<bool> addLink(int agentID, String link) async {
  int result = await LinkModel().addLink(agentID, link);
  if (result != -1) {
    return true;
  } else {
    return false;
  }
}


Future<List<Link>> getLinks(int agentID) async{
  return await LinkModel().getLinkList(agentID);
}


Future<bool> deleteLink(int agentID, int linkID) async{
  return await LinkModel().deleteLink(agentID, linkID);
}

