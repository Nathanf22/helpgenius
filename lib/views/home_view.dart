// lib/views/main_page.dart

import 'package:helpgenius/model/data.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  final Widget widget;
  const HomeView({super.key, required this.widget});
  
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints.tight(MediaQuery.of(context).size),
        // constraints: BoxConstraints.expand(screenwidth, screenheight)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.7, -2),
            end: Alignment.topCenter,
            colors: [ Color.fromARGB(200, 0, 0, 36), Color.fromARGB(255, 0, 0, 36)], // Couleurs du dégradé
          ),
        ),
        child: widgetToDisplay,
      ),
    );
         
  }
}

