import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String? errorText;
  final IconData icon;
  final Color? color;
  final Function(String text) onChanded;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? textInputType;

  const DefaultTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanded,
    this.obscureText = false,
    this.errorText,
    this.validator,
    this.initialValue,
    this.color = Colors.white,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      initialValue: widget.initialValue,
      onChanged: widget.onChanded,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: TextStyle(
            color: widget.color,
            fontSize: 16,
          ),
        ),
        errorText: widget.errorText,
        prefixIcon: Icon(
          widget.icon,
          color: widget.color,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color!),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: widget.color,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
      ),
      style: TextStyle(
        color: widget.color,
      ),
    );
  }
}