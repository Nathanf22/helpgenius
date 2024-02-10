import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helpgenius/services/snackbar.dart';
import 'package:helpgenius/views/components/file_item.dart';
import 'package:helpgenius/views/components/multiligne_text_field.dart';
import 'package:helpgenius/views/components/url_list.dart';
import 'package:helpgenius/viewsModel/home_view_model.dart';

class SourceView extends StatefulWidget {
  const SourceView({super.key});

  @override
  State<SourceView> createState() => _SourceViewState();
}

class _SourceViewState extends State<SourceView> {
  List<File> _files = [];
  List<Uint8List?> _filesBytes = [];
  bool _dragging = false;
  final HomeViewModel viewModel = HomeViewModel();
  List<FileItem> files = [];
  List<String> agentsNames = [];
  String? selectedAgent = '' ;
  String? selectedModel = 'Model 1';
  int agentID = -1;
  

  void _onAgentDropdownChanged(String? newValue) {
    selectedAgent = newValue;
    agentID = selectedAgent=='' ? -1 : int.parse(selectedAgent!.split(":")[0]);
    viewModel.getFiles(agentID).then((f) {
        files = f;
        setState(() {
          
        });
      });
  }

  void _onModelDropdownChanged(String? newValue) {
    setState(() {
      selectedModel = newValue;
    });
  }

  
  
  
  @override
  void initState() {
    
    viewModel.getAgentsNames().then((names){
      print("finished getAgentsNames");
      agentsNames = names;
      print(names);
      selectedAgent = agentsNames[0];
      agentID = selectedAgent=='' ? -1 : int.parse(selectedAgent!.split(":")[0]);
      print("agent id: $agentID");
      viewModel.getFiles(agentID).then((f) {
        files = f;
        setState(() {
          
        });
      });
    });
    super.initState();
    // Appelez une fonction asynchrone pour charger les données
    // files = loadFilesData();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    int columnsCount = MediaQuery.of(context).size.width ~/ 400; // 200 est la largeur approximative d'un élément
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
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
            agentsNames.isNotEmpty ? Container(
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
              items: agentsNames
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.grey),),
                );
              }).toList(),
                        ),
            ): const SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('Files',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal
                ),),
            ),
            Center(
              child: DropTarget(
                onDragDone: (detail) {
                  setState(() {
                    // print('dropping');
                    _files = detail.files.map((file) => File(file.path)).toList();
                    // viewModel.addFiles(_files);
                    // _list.addAll(detail.files);
                  });
                },
                onDragEntered: (detail) {
                  setState(() {
                    // print('Entering');
                    _dragging = true;
                  });
                },
                onDragExited: (detail) {
                  setState(() {
                    // print('Exiting');
                    _dragging = false;
                  });
                },
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12), // Ajustez le rayon du coin du rectangle
                    padding: const EdgeInsets.all(10),
                    borderPadding: const EdgeInsets.all(20), // Ajustez la marge intérieure du rectangle
                    color: Colors.white, // Couleur de la bordure en trait interrompu
                    strokeWidth: 2, // Épaisseur de la bordure
                    dashPattern: const [5, 5], // Style de la bordure en trait interrompu (5 unités pleines, 5 unités vides)
                    child:  Container(
                      margin: const EdgeInsets.all(10),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient:  LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: _dragging?[ const Color.fromARGB(50, 1, 50, 52), const Color.fromARGB(255, 1, 50, 52)]: [ const Color.fromARGB(50, 1, 1, 52), const Color.fromARGB(255, 1, 1, 52)], // Couleurs du dégradé
                        ),
                      ),
                      width: double.infinity, // Ajustez la largeur du rectangle selon vos besoins
                      height: screenSize.height * 0.35, // Ajustez la hauteur du rectangle selon vos besoins
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Text(
                              'Drag and Drop your file here to start uploading',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12, // Ajustez la taille de la police selon vos besoins
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12, // Ajustez la taille de la police selon vos besoins
                              ),
                            ),
                            const SizedBox(height: 10,),
                            OutlinedButton(
                                onPressed: () async{
                                    FilePickerResult? picked = await FilePicker.platform.pickFiles();
                                    if (picked != null) {
                                      agentID = selectedAgent=='' ? -1 : int.parse(selectedAgent!.split(":")[0]);
                                      print("agent ID: $agentID");
                                      // picked.files.map((e) => await viewModel.uploadFile(filename: filename, file: file))
                                     await Future.wait(picked.files.map((file) async => await viewModel.addFile(name: file.name, bytes: file.bytes, size: file.size, extension: file.extension, agentID:agentID)).toList());
                                     files = await viewModel.getFiles(agentID);
                                     setState(() {
                                      
                                     });
                                      // print(picked.files.first.name);
                                      // viewModel.addFiles(_files);
                                    }
                                },
                                style: OutlinedButton.styleFrom(
                                  // foregroundColor: Colors.green, 
                                  side: const BorderSide(color: Colors.green), // Couleur et style de la bordure (verte)
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                   shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Ajustez le rayon des coins du bouton ici
                                  ),
                                ),
                                child: const Text(
                                  'Browse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, // Ajustez la taille de la police selon vos besoins
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Column(
              mainAxisSize: MainAxisSize.min,
              // height: 200,
              children: [
                files.isNotEmpty ? Flexible(
                child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnsCount != 0 ? columnsCount: 1,
                  mainAxisSpacing: 8.0, // Espacement vertical entre les éléments
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3, // Espacement horizontal entre les éléments
                ),
                itemCount: files.length,
                itemBuilder: (BuildContext context, int index) {
                  final file = files[index];
                  return FileItem(
                    fileName: file.fileName,
                    fileSize: file.fileSize,
                    fileExtension: file.fileExtension,
                    download: (){},
                    delete: () async{
                      agentID = int.parse(selectedAgent!.split(":")[0]);
                       String result = await viewModel.removeFile("${file.fileName}.${file.fileExtension}", agentID);
                        if (result != 'success'){
                        showErrorSnackBar(context, result);
                        }
                        else{
                          
                          files = await viewModel.getFiles(agentID);
                        showSuccessSnackBar(context, 'File deleted');
                        }
                      setState((){
                       
                      });
                      
                        },
                    );
                  },
                ),
              ):
              const SizedBox.shrink(),
              ] ,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('URLs',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal
                ),),
            ),
            MyUrlList(agentID: agentID,),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('Text',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal
                ),),
            ),
            const MyMultilineTextField(label: 'Text'),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('Instructions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal
                ),),
            ),
            const MyMultilineTextField(label: 'Instructions'),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('Model',
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
              value: selectedModel,
              onChanged: _onModelDropdownChanged,
              items: <String>['Model 1', 'Model 2', 'Model 3', 'Model 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.grey),),
                );
              }).toList(),
                        ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      );
    
  }
}