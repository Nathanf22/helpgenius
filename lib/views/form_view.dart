import 'package:flutter/material.dart';
import 'package:helpgenius/views/components/custom_button2.dart';




class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
   List<FormContainer> formContainers = [];

  void _addFormContainer() {
    setState(() {
      formContainers.add(const FormContainer());
    });
  }
  void _removeFormContainer(int index) {
    setState(() {
      formContainers.removeAt(index);
    });
  }
  String? selectedAgent = 'Agent 1';

  void _onAgentDropdownChanged(String? newValue) {
    setState(() {
      selectedAgent = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('Agent',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal
                ),),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
              // underline: Container(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: const Divider(
              //     // height: , // Espace entre la ligne et la liste déroulante
              //     thickness: 2,
              //     color: Colors.white, // Épaisseur de la ligne
              //     // indent: 10,
              //   ),
              // ),
              isExpanded: true,
              dropdownColor: const Color.fromARGB(255, 0, 0, 36),
              value: selectedAgent,
              onChanged: _onAgentDropdownChanged,
              items: <String>['Agent 1', 'Agent 2', 'Agent 3', 'Agent 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.grey),),
                );
              }).toList(),
                        ),
            ),
            // const FormContainer(),
            Column(
              children: formContainers
              .asMap()
                  .entries
                  .map((entry) {
                    final index = entry.key;
                    final form = entry.value;
                    return Column(
                      children: [
                        form,
                        CustomButton2(
                          text: 'Delete Form', 
                          color: Colors.red,
                          onPressed: () {
                              _removeFormContainer(index);
                            },),   
                      ],
                    );
                  })
                  .toList(),
            ),
            const SizedBox(height: 10,),
            CustomButton2(
              text: 'Add Form', 
              color: Colors.green,
              onPressed: () {
                  _addFormContainer();
            },),
        //     FloatingActionButton(
        //   onPressed: _addFormContainer,
        //   child: const Icon(Icons.add, ),
        // ),
        ],),
      ),
    );
  }
}

class FormContainer extends StatefulWidget {
  const FormContainer({super.key});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  List<FormFieldEntry> formFields = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController webhookController = TextEditingController();

  String selectedFieldType = 'text'; // Par défaut, le type est "text"
  List<String> listFieldOptions = [];

  void _addFormField() {
    setState(() {
      formFields.add(FormFieldEntry(
        fieldName: TextEditingController(),
        description: TextEditingController(),
        fieldType: selectedFieldType,
        listOptions: List.from(listFieldOptions),
      ));
    });
  }

  void _removeFormField(int index) {
    setState(() {
      formFields.removeAt(index);
    });
  }

  void _removeOption(FormFieldEntry field, int index) {
    setState(() {
      field.listOptions.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Form Name',
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: purposeController,
          decoration: const InputDecoration(
            labelText: 'Purpose',
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: webhookController,
          decoration: const InputDecoration(
            labelText: 'Webhook',
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        Column(
          children: formFields.asMap().entries.map((entry) {

            final index = entry.key;
            final field = entry.value;
            return Card(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: field.fieldName,
                    decoration: const InputDecoration(
                      labelText: 'Field Name',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: field.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: const Color.fromARGB(255, 0, 0, 36),
                    value: field.fieldType,
                    onChanged: (value) {
                      setState(() {
                        field.fieldType = value!;
                        if (value == 'list') {
                          // Définissez les options par défaut pour le type "list"
                          field.listOptions = ['Option 1', 'Option 2'];
                        } else {
                          field.listOptions.clear();
                        }
                      });
                    },
                    items: ['text', 'number', 'link', 'list']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white),),
                      );
                    }).toList(),
                  ),
                  if (field.fieldType == 'list')
                    Column(
                      children: <Widget>[
                        for (var i = 0; i < field.listOptions.length; i++)
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: TextEditingController(text: field.listOptions[i]),
                                  decoration: const InputDecoration(
                                    labelText: 'Option',
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red,),
                                onPressed: () {
                                  _removeOption(field, i);
                                },
                              ),
                            ],
                          ),
                          CustomButton2(text: 'Add Option', 
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                field.listOptions.add('');
                              });
                            },),
                            const SizedBox(height: 10,)
                        // ElevatedButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       field.listOptions.add('');
                        //     });
                        //   },
                        //   child: const Text('Add Option'),
                        // ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  CustomButton2(
                    text: 'Remove Field',
                    color: Colors.red, 
                    onPressed: () {
                        _removeFormField(index);
                      },),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _removeFormField(index);
                  //   },
                  //   child: Text('Remove Field'),
                  // ),
                ],
              ),
            );
          }).toList(),
        ),
        CustomButton2(
          text: 'Add Field',
          color: Colors.blue, 
          onPressed: _addFormField
        ),
        const SizedBox(height: 10,)
        // ElevatedButton(
        //   onPressed: _addFormField,
        //   child: const Text('Add Field'),
        // ),
      ],
    );
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Traitement pour ajouter le formulaire avec les champs au backend
          for (var field in formFields) {
            print('Field Name: ${field.fieldName.text}');
            print('Description: ${field.description.text}');
            print('Type: ${field.fieldType}');
            if (field.fieldType == 'list') {
              print('List Options: ${field.listOptions}');
            }
          }
        },
        child: Icon(Icons.add),
      );
  }
}

class FormFieldEntry {
  TextEditingController fieldName;
  TextEditingController description;
  String fieldType;
  List<String> listOptions;

  FormFieldEntry({
    required this.fieldName,
    required this.description,
    required this.fieldType,
    required this.listOptions,
  });
}