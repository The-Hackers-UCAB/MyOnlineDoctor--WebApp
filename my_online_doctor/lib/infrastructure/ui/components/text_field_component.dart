import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_form_field_component.dart';

class TextFieldBaseComponent extends StatefulWidget {
  final String hintText;
  final String errorMessage;
  final int minLength;
  final int maxLength;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;


  const TextFieldBaseComponent({Key? key, 
    required this.hintText,
    required this.errorMessage,
    required this.minLength,
    required this.maxLength,
    required this.textEditingController,
    required this.keyboardType,
    this.obscureText = false,

  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldBaseComponentState createState() =>
      _TextFieldBaseComponentState();
}

class _TextFieldBaseComponentState extends State<TextFieldBaseComponent> {

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormFieldBaseComponent(
          hintText: widget.hintText,
          errorMessage: widget.errorMessage,
          minLength: widget.minLength, 
          maxLength: widget.maxLength, 
          textEditingController: widget.textEditingController,
          keyboardType: widget.keyboardType,
          isPassword: widget.obscureText,
        )
      ],
    );
  }
}