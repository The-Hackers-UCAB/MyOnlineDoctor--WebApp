// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';
import 'package:my_online_doctor/infrastructure/utils/validator_util.dart';

// Project imports:

class TextFormFieldBaseComponent extends StatefulWidget {
  final String? errorMessage;
  final int minLength;
  final int? maxLength;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final String? hintText;
  final String initialValue;

  // final Function functionValidate;
  // final Function functionIconPassword;
  // final Function functionOnSave;
  final bool enabled;
  final bool isPassword;
  final bool validateSpaces;
  final bool isUsername;
  final bool isAmount;
  final bool isDate;

  // final bool white;
  final bool isOtp;
  final bool
      numberWithSpaces; //Si es opcional el campo, numérico y permite caracters especiales.

  // final bool obscureField;
  // final String hint;
  final bool validate;

  TextFormFieldBaseComponent({
    required this.errorMessage,
    required this.minLength,
    this.maxLength,
    this.textEditingController,
    required this.keyboardType,
    this.hintText,
    this.initialValue = '',
    // @required this.functionValidate,
    // this.functionIconPassword,
    // @required this.functionOnSave,
    this.isPassword = false,
    this.validateSpaces = false,
    this.isUsername = false,
    this.isAmount = false,
    // this.white = true,
    this.isOtp = false,
    this.numberWithSpaces = false,
    this.enabled = true,
    this.isDate = false,
    // this.obscureField,
    // this.hint,
    this.validate = true
  });

  @override
  _TextFormFieldBaseComponentState createState() =>
      _TextFormFieldBaseComponentState();
}

class _TextFormFieldBaseComponentState
    extends State<TextFormFieldBaseComponent> {
  bool obscureField = false;

  @override
  void initState() {
    obscureField = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyleFormField(false),
      //Validacion de color
      decoration: _border().copyWith(
        filled: true,
        fillColor: colorWhite,
        hintStyle: const TextStyle(
            color: colorBlack,
            fontWeight: FontWeight.w400,
            fontFamily: 'Garet Light'),
        //Validacion de color
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureField = !obscureField;
                  });
                },
                icon: obscureField
                    ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: colorPrimary,
                      )
                    : const Icon(
                        Icons.visibility,
                        size: 20,
                        color: colorPrimary,
                      ),
              )
            : null,
        // labelStyle: Theme.of(context).textTheme.bodyText1,
        // labelText: widget.hint,
      ),
      enabled: widget.enabled,
      cursorColor: Colors.white,
      //Validacion de color
      inputFormatters: [
        // if (widget.validateSpaces) FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
        if ( ((widget.keyboardType == TextInputType.number) || widget.isAmount)  && !widget.numberWithSpaces)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),

        if (widget.validateSpaces)
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.!#%&’*+/=?^_`{|}~-]')),

        if (widget.isUsername)
          FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]([._-](?![.-])|[a-zA-Z0-9])*')),

        // if (widget.keyboardType == const TextInputType.numberWithOptions(
        //     signed: true, decimal: true))
        //   CurrencyTextInputFormatter(
        //     locale: 'es',
        //     decimalDigits: 2,
        //     symbol: '',
        //   )


        // '[a-zA-Z0-9.!#%&’*+/=?^_`{|}~-]'
        // ^[A-Za-z]\S*
        // ^[a-zA-Z0-9]([._-](?![.-])|[a-zA-Z0-9]){1,30}[a-zA-Z0-9]$
      ],
      // initialValue: widget.initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      obscureText: obscureField,
      buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) =>
          null,
      validator: (value) {
        if((value?.isEmpty ?? false) && !widget.validate) {
          return null;
        }
        if (widget.textEditingController?.text.contains('-') ?? false) {

          if(!widget.isDate) return 'No se aceptan guiones';
        }



        if ((value!.length < widget.minLength) ||
            (widget.keyboardType == TextInputType.emailAddress &&
                !ValidatorUtil.isEmail(value)) ||
            ((widget.isUsername == true) &&
                ((widget.textEditingController!.text.endsWith('-')) ||
                    (widget.textEditingController!.text.endsWith('_')) ||
                    (widget.textEditingController!.text.endsWith('.'))))) {
          return widget.errorMessage;
        } else if (widget.textEditingController?.text == '0,00') {
          return widget.errorMessage;
        } else {
          return null;
        }
      },
      // onSaved: (value) => widget.functionOnSave(value),
    );
  }

  InputDecoration _border() {
    return boxTextFormFieldDecorationDefault(); //Validacion de color
  }
}
