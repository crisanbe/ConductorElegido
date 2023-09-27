import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadPDFWidget extends StatelessWidget {
    final Function(File, String) onUpload;

    UploadPDFWidget({required this.onUpload});

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
            ElevatedButton(
                onPressed: () async {
                // Abre un diálogo para seleccionar un archivo PDF
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
                );

                if (result != null) {
                    File pdfFile = File(result.files.single.path!);

                    // Puedes cambiar 'nombre_del_archivo' por el nombre que desees
                    String fileName = 'nombre_del_archivo';

                    onUpload(pdfFile, fileName);
                }
            },
            child: Text('Subir PDF'),
        ),
        ],
        );
    }
}
