import 'package:flutter/material.dart';

SelectOptionImageDialog(BuildContext context, Function() pickImage, Function() takePhoto){
  return showDialog(
    context: context, 
    builder: (BuildContext context) => AlertDialog(
      title: Text("Selecciona una opción"),
      actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            pickImage();
          }, 
          child: Text(
            'Galería',
            style: TextStyle(color: Colors.black),
          )
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            takePhoto();
          }, 
          child: Text(
            'Cámara',
            style: TextStyle(color: Colors.black),
          )
        ),
      ],
    )
  );
}