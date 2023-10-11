import 'package:flutter/material.dart';

class DocumentSelectionButton extends StatefulWidget {
    final String buttonText;
    final VoidCallback onPressed;
    final bool isSelected;
    final String? selectedFileName;

    const DocumentSelectionButton({
        required this.buttonText,
        required this.onPressed,
        required this.isSelected,
        this.selectedFileName,
    });

    @override
    _DocumentSelectionButtonState createState() => _DocumentSelectionButtonState();
}

class _DocumentSelectionButtonState extends State<DocumentSelectionButton> {
    @override
    Widget build(BuildContext context) {
        return Center(
            child: Container(
                width: 250, // Ajusta el ancho según tus necesidades
                child: ElevatedButton(
                    onPressed: widget.onPressed,
                    style: ElevatedButton.styleFrom(
                        primary: widget.isSelected ? Colors.blue : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Icon(Icons.insert_drive_file, color: Colors.white),
                            SizedBox(width: 8),
                            AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: Container(
                                    key: UniqueKey(),
                                    constraints: BoxConstraints(maxWidth: 120), // Ajusta el ancho máximo del texto según tus necesidades
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            widget.selectedFileName != null && widget.selectedFileName!.isNotEmpty
                                                ? widget.selectedFileName!
                                                : widget.buttonText,
                                            style: TextStyle(fontSize: 16),
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}



///SizedBox(height: widget.isSelected ? 0 : 4), // Ajuste para evitar la separación vertical cuando está seleccionado
/*  if (widget.isSelected &&
                    widget.selectedFileName != null &&
                    widget.selectedFileName!.isNotEmpty)*/
//const Text("")
/* Text(
                        'Archivo seleccionado: ${widget.selectedFileName}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                    ),*/
