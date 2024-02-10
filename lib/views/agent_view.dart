import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:helpgenius/services/snackbar.dart';
import 'package:helpgenius/views/components/custom_button2.dart';
import 'package:helpgenius/viewsModel/agent_view_model.dart';

class AgentView extends StatefulWidget {
  const AgentView({super.key});

  @override
  State<AgentView> createState() => _AgentViewState();
}

class _AgentViewState extends State<AgentView> {

  @override
  Widget build(BuildContext context) {
    return const AgentCreator();
  }
}

class AgentCreator extends StatefulWidget {
  const AgentCreator({super.key});

  @override
  State<AgentCreator> createState() => _AgentCreatorState();
}

class _AgentCreatorState extends State<AgentCreator> {
  final AgentViewModel viewModel = AgentViewModel();
  List<Agent> agents = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState(){
    viewModel.getAgentsList().then((response){
      agents = response;
      setState(() {
        
      });
    });
    super.initState();
  }

  void _addAgent() {
    viewModel.addAgent(nameController.text, descriptionController.text).then(
      (result) async{
        if (result){
          showSuccessSnackBar(context, "Agent ajoute avec succes: $result");
          agents = await viewModel.getAgentsList();
           setState(() {
          nameController.clear();
          descriptionController.clear();
        });
        }
        else{
          showErrorSnackBar(context, "Erreur lors de l'ajout");
        }
      }
    );
    
  }

  void _removeAgent(int agentID) {
    viewModel.removeAgent(agentID).then((result){
      if (result){
        showSuccessSnackBar(context, "Agent suprime avec succes");
        viewModel.getAgentsList().then((value){
          agents = value;
          setState(() {
            
          });
        });
      }
      else{
        showErrorSnackBar(context, "erreur lors de la supression");
      }
    });
    // setState(() {
    //   agents.removeAt(index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Agent Name',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  CustomButton2(
                    text: 'Add Agent',
                    onPressed: _addAgent,
                  ),
                  const SizedBox(height: 20),
                  const Text('Existing Agent(s)', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      agents.isNotEmpty ? Flexible(
                        child: ListView.builder(
                          shrinkWrap: true, // Permet à ListView de s'adapter à sa hauteur parente
                          itemCount: agents.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  'Name: ${agents[index].name}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Description: ${agents[index].description}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _removeAgent(agents[index].id);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ):
                      const SizedBox.shrink(),
                    ],
                  ),
    
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Agent {
  int id;
  String name;
  String description;

  Agent({
    required this.id,
    required this.name,
    required this.description,
  });
}