

import 'package:flutter/material.dart';
import 'package:helpgenius/views/form_view.dart';
import 'package:helpgenius/views/home_view.dart';
import 'package:helpgenius/views/source_view.dart';

List<Map<String, String>> filesModel = [
  {
    "fileName": "MonFichier1",
    "fileSize": "1.2 MB",
    "fileExtension": "pdf"
  },
  {
    "fileName": "MonFichier2",
    "fileSize": "0.8 MB",
    "fileExtension": "docx"
  },
  {
    "fileName": "MonFichier3",
    "fileSize": "2.0 MB",
    "fileExtension": "xlsx"
  },
   {
    "fileName": "MonFichier4",
    "fileSize": "1.2 MB",
    "fileExtension": "pdf"
  },
  {
    "fileName": "MonFichier5",
    "fileSize": "0.8 MB",
    "fileExtension": "docx"
  },
  {
    "fileName": "MonFichier6",
    "fileSize": "2.0 MB",
    "fileExtension": "xlsx"
  }
];

Widget widgetToDisplay = const SourceView();