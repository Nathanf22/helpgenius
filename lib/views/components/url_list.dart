import 'package:flutter/material.dart';

class MyUrlList extends StatefulWidget {
  const MyUrlList({super.key});

  
  @override
  State<MyUrlList> createState() => _MyUrlListState();
}

class _MyUrlListState extends State<MyUrlList> {
  final TextEditingController urlController = TextEditingController();
  List<String> urlList = ['www.helpgenius-ai.com/'];

  void _addUrl() {
    String newUrl = urlController.text;
    if (newUrl.isNotEmpty) {
      setState(() {
        urlList.add(newUrl);
        urlController.clear();
      });
    }
  }

  void _removeUrl(int index) {
    setState(() {
      urlList.removeAt(index);
    });
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
                      title: Text(urlList[index], style: const TextStyle(color: Colors.grey),),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: () {
                          _removeUrl(index);
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