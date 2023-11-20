import 'package:helpgenius/views/components/delete_confirmation.dart';
import 'package:helpgenius/views/components/file_popup.dart';
import 'package:flutter/material.dart';

class FileItem extends StatefulWidget {
  ///File Item is the representation of a file, it require a filename, and can take
  ///a filesize , and the file extesion 

  final String fileName;
  final String? fileSize;
  final String? fileExtension;
  final VoidCallback? delete;
  final VoidCallback? download;

  const FileItem({super.key, 
    required this.fileName,
    this.fileSize,
    this.fileExtension,
    this.delete,
    this.download
  });

  @override
  State<FileItem> createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  bool isHovered = false;

  void _handleHover(bool isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  // Méthode pour obtenir la couleur de l'icône en fonction de l'extension du fichier
  Color getIconColor(String? extension) {
    if(extension != null){
        switch (extension.toLowerCase()) {
        case 'pdf':
          return Colors.white;
        case 'doc':
          return Colors.blue;
        case 'docx':
          return Colors.blue;
        case 'xls':
          return Colors.green;
        case 'xlsx':
          return Colors.green;
        case 'ppt':
          return Colors.orange;
        case 'pptx':
          return Colors.orange;
        default:
          return Colors.purple;
      } 
    }
    else{
      return Colors.purple;
    }
    
  }

  // Méthode pour obtenir l'icône en fonction de l'extension du fichier
  IconData getIconData(String? extension) {
    if(extension != null){
        switch (extension.toLowerCase()) {
        case 'pdf':
          return Icons.picture_as_pdf;
        case 'doc':
          return Icons.description;
        case 'docx':
          return Icons.description;
        case 'xls':
          return Icons.table_chart;
        case 'xlsx':
          return Icons.table_chart;
        case 'ppt':
          return Icons.slideshow;
        case 'pptx':
          return Icons.slideshow;
        default:
          return Icons.insert_drive_file;
      }
    }
    else{
       return Icons.insert_drive_file;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: (){
          showDialog(
            context: context, 
            builder:  ((context) => FilePopup(
              onDownloadPressed: (){
                widget.download!();
              }, 
              onDeletePressed: (){
                showDialog(
                context: context,
                builder: (context) => DeleteConfirmation(
                  itemName: "Item to delete", // Nom de l'élément à supprimer
                  onConfirm: () {
                    widget.delete!();
                    // Action de suppression réelle
                    // print('Deletion Done');
                  },
                ),
              );
              }
              )),);
        },
        child: Card(
          margin: const EdgeInsets.all(10),
          // shape: ShapeBorder.lerp(a, b, t),
          color: isHovered? const Color.fromARGB(150 , 1, 1, 80) :const Color.fromARGB(150 , 1, 1, 52),
          child: ListTile(
            key: widget.key,
            // hoverColor: Colors.white,
            // tileColor:  Colors.white,
            leading: Icon(
              getIconData(widget.fileExtension),
              color: getIconColor(widget.fileExtension),
            ),
            title: Text(widget.fileName,
            style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text('Size: ${widget.fileSize ?? 'Unknown'} | ${widget.fileExtension ?? 'Unknown'}',
            style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
