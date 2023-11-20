import 'package:flutter/material.dart';


class MyMultilineTextField extends StatefulWidget {
  final String label;
  const MyMultilineTextField({super.key, required this.label});

  @override
  State<MyMultilineTextField> createState() => _MyMultilineTextFieldState();
}


class _MyMultilineTextFieldState extends State<MyMultilineTextField> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          style: const TextStyle(color: Colors.grey),
          controller: textController,
          maxLines: null, // Permet un nombre de lignes dynamique
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxHeight: 500),
            labelText: widget.label,
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
          ),
        ),
      );
   
  }
}