import 'package:flutter/material.dart';
import 'package:helpgenius/model/link_model.dart';
import 'package:helpgenius/services/snackbar.dart';
import 'package:helpgenius/viewsModel/home_view_model.dart';

class MyUrlList extends StatefulWidget {
  final int agentID;
  const MyUrlList({super.key, required this.agentID});

  
  @override
  State<MyUrlList> createState() => _MyUrlListState();

}

class _MyUrlListState extends State<MyUrlList> {
  final HomeViewModel viewModel = HomeViewModel();
  final TextEditingController urlController = TextEditingController();
  List<Link> urlList = [];

  void _addUrl() {
    String newUrl = urlController.text;
    viewModel.newLink(widget.agentID, newUrl);
    viewModel.getLinkList(widget.agentID).then((value){
      urlList = value;
      urlController.clear();
      // print("urlList: $urlList");
      setState(() {
        
      });
    });
    // if (newUrl.isNotEmpty) {
    //   setState(() {
    //     urlList.add(newUrl);
    //     urlController.clear();
    //   });
    // }
  }

  void _removeUrl(int urlID) {
    viewModel.removeLink(widget.agentID, urlID).then((value){
      if (value){
        showSuccessSnackBar(context, "lien suprime avec succes");
         viewModel.getLinkList(widget.agentID).then((value){
        print("urlList: $urlList");
        urlList = value;
        setState(() {
          
        });
      });
      }
      else{
        showErrorSnackBar(context, "Erreur lors de la supression du lien");
      }
     
    });
    
    // setState(() {
    //   urlList.removeAt(index);
    // });
  }

  @override
  void initState() {
     viewModel.getLinkList(widget.agentID).then((value){
      urlList = value;
      // print("urlList: $urlList");
      setState(() {
        
      });
    });
    super.initState();
  }
  @override
  void didUpdateWidget(MyUrlList oldWidget) {
     viewModel.getLinkList(widget.agentID).then((value){
      urlList = value;
      print("agentID:  ${widget.agentID}");
      print("urlList: $urlList");
      setState(() {
        
      });
    });
    super.didUpdateWidget(oldWidget);
    // Vérifiez si les propriétés du widget ont changé
    // if (widget != oldWidget) {
    //   // Les propriétés du widget ont changé, appelez la fonction de mise à jour
    //   widget.onReload();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    style: const TextStyle(color: Colors.grey),
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Saisir une URL',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Couleur du bord en focus
                        ),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue, // Couleur du bord en focus
                        ),),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white,),
                  onPressed: _addUrl,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: urlList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(urlList[index].link ?? '', style: const TextStyle(color: Colors.grey),),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: () {
                          _removeUrl(urlList[index].id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
  }
}