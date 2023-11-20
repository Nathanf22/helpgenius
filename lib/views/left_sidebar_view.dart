// lib/views/left_sidebar.dart

import 'package:helpgenius/model/data.dart';
import 'package:helpgenius/views/agent_view.dart';
import 'package:helpgenius/views/components/custom_button1.dart';
import 'package:helpgenius/views/components/custom_button2.dart';
import 'package:helpgenius/views/components/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:helpgenius/views/form_view.dart';
import 'package:helpgenius/views/home_view.dart';
import 'package:helpgenius/views/integration_view.dart';
import 'package:helpgenius/views/source_view.dart';
import 'package:helpgenius/views/test_view.dart';

class LeftSidebarView extends StatefulWidget {
  final VoidCallback refreshParent;
  const LeftSidebarView({super.key, required this.refreshParent});

  @override
  State<LeftSidebarView> createState() => _LeftSidebarViewState();
}

class _LeftSidebarViewState extends State<LeftSidebarView> {
  String selectedPage = 'Sources';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const Color selectedColor = Colors.green;
    // Votre contenu du sidebar
    return Container(
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.7, -3),
            end: Alignment.bottomRight,
            colors: [ Color.fromARGB(230, 1, 1, 52), Color.fromARGB(255, 1, 1, 52)], // Couleurs du dégradé
          ),
        ),
      child: screenSize.width >= 600 ? Drawer(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('Agents',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: selectedPage == 'Agents' ? selectedColor :Colors.white),
                        ),
                        onTap: () {
                          widgetToDisplay = const AgentView();
                          setState((){
                            selectedPage = 'Agents';
                            
                          });
                          widget.refreshParent();
                          // showDialog(
                          //   context: context, 
                          //   builder: (context)=> const InfoDialog(
                          //   title: 'Tache 1(pas disponible)', 
                          //   message: 'Extraire les informations du PDF généré par sage, et les ecrire dans le fichier excel de la DSF'));
                          // Gérez la navigation ou l'action lorsque l'option 1 est sélectionnée
                        },
                      ),
                      ListTile(
                        
                        title: Text('Sources',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: selectedPage == 'Sources' ? selectedColor :Colors.white),),
                        // selected: selectedPage == 'Sources',
                        // tileColor: selectedPage == 'Sources' ? selectedColor : null,
                        selectedColor: selectedColor,
                        // selectedTileColor: selectedColor,
                        onTap: () {
                          // HomeView.setWidgetToDisplay(const SourceView());
                          widgetToDisplay = const SourceView();
                          
                          // setState(() {
                          selectedPage = 'Sources';
                            // print(selected);
                          // });
                          widget.refreshParent();
                           
                          // Navigator.pop(context);
                          // Gérez la navigation ou l'action lorsque l'option 2 est sélectionnée
                          // showDialog(
                          //   context: context, 
                          // builder: (context)=> const InfoDialog(
                          //   title: 'Tache 2 (pas disponible)', 
                          //   message: 'Regrouper toutes les analyses des fournisseurs dans un document PDF'));
                        },
                      ),
                      ListTile(
                        title:  Text('Forms',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: selectedPage == 'Forms' ? selectedColor :Colors.white),),
                        // selected: selectedPage == 'Forms',
                        selectedColor: selectedColor,
                        // tileColor: selectedPage == 'Sources' ? selectedColor : null,
                        // selectedTileColor: selectedColor,
                        onTap: (){
                          // HomeView.setWidgetToDisplay(const FormView());
                          widgetToDisplay = const FormView();
                          setState((){
                            selectedPage = 'Forms';
                            
                          });
                          widget.refreshParent();
                          
                        },
                      ),
                      ListTile(
                        title: Text('Integrations',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: selectedPage == 'Integrations' ? selectedColor :Colors.white),),
                        onTap: (){
                          widgetToDisplay = IntegrationView();
                          setState((){
                            selectedPage = 'Integrations';
                            
                          });
                          widget.refreshParent();

                        },
                      ),
                      ListTile(
                        title: Text('Tests',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: selectedPage == 'Tests' ? selectedColor :Colors.white),),
                        onTap: (){
                          widgetToDisplay = const TestView();
                          setState((){
                            selectedPage = 'Tests';
                            
                          });
                          widget.refreshParent();

                        },
                      ),
                      // Ajoutez d'autres options ici
                    ],
                  ),
                ),
                const Divider(),
                CustomButton1(text: 'Save',
                 onPressed: (){

                 }
                 ),
                 const SizedBox(height: 10,),
                 CustomButton2(text: 'Disconnect', 
                 onPressed: (){

                 }),
                 const SizedBox(height: 10,)
              ],
            ),
          ):
          const SizedBox.shrink()
      );
  }
}
