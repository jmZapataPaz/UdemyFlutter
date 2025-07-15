import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  String? errorText;
  IconData icon;
  Function (String text) onChanded;
  bool obscureText = false;
  
  DefaultTextField({
    required this.label,
    required this.icon,
    required this.onChanded,
    this.obscureText = false,
    this.errorText,
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText, //para que sea un campo de contraseña
      onChanged: (text){
        onChanded(text);
      },
      decoration: InputDecoration(
        label: Text(label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          ),
        ),
        errorText: errorText,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white,)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white,
          ) 
        ),
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}