import 'package:flutter/material.dart';

class Text_Field {
  static final Textselect = MaterialTextSelectionControls();
  static Create_textFiled(
          String hint, TextEditingController control, int maxline) =>
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: TextField(
          controller: control,
          selectionControls: Textselect,
          onChanged: (i) {},
          minLines: 1,
          maxLines: maxline,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: hint + " edite",
              label: Text(
                hint,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
              prefix: SizedBox(width: 10),
              hintStyle: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5)),
        ),
      );
}
