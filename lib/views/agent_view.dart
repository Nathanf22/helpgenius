import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:helpgenius/views/components/custom_button2.dart';

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
  List<Agent> agents = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _addAgent() {
    setState(() {
      agents.add(Agent(
        name: nameController.text,
        description: descriptionController.text,
      ));
      nameController.clear();
      descriptionController.clear();
    });
  }

  void _removeAgent(int index) {
    setState(() {
      agents.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            for (var index = 0; index < agents.length; index++)
              Card(
                color: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text('Name: ${agents[index].name}', style: const TextStyle(color: Colors.white),),
                  subtitle: Text('Description: ${agents[index].description}',style: const TextStyle(color: Colors.white),),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    onPressed: () {
                      _removeAgent(index);
                    },
                  ),
                ),
              ),
          ],
        ),
      );
  }
}

class Agent {
  String name;
  String description;

  Agent({
    required this.name,
    required this.description,
  });
}