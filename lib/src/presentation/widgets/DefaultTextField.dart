import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  String? initialValue;
  String? errorText;
  IconData icon;
  Color? color;
  Function (String text) onChanded;
  String? Function(String?)? validator;
  bool obscureText = false;
  TextInputType? textInputType;
  
  DefaultTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanded,
    this.obscureText = false,
    this.errorText,
    this.validator,
    this.initialValue,
    this.color = Colors.white,
    this.textInputType = TextInputType.text
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText, //para que sea un campo de contraseña
      initialValue: initialValue,
      onChanged: (text){
        onChanded(text);
      },
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 16,
          ),
        ),
        errorText: errorText,
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color!,)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color!,
          ) 
        ),
      ),
      style: TextStyle(
        color: color,
      ),
    );
  }
}