// Flutter imports:
import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';

import '../styles/colors.dart';

class DialogComponent extends StatelessWidget {
  final String? textTitle;
  final String? textQuestion;
  final String? textBtnAccept;
  final String? textBtnCancel;
  final bool cancelButton;

  const DialogComponent({Key? key, this.textTitle, this.textQuestion, this.cancelButton = false, this.textBtnAccept, this.textBtnCancel}) : super(key: key);

  final double latMargin = 12.0;
  final double topMargin = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      backgroundColor: colorSecondary,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: [
              if (textTitle != null) _textMessage(true, context),
              if (textQuestion != null) _textMessage(false, context),
            ],
          ),
        ),
        _buttons(context),
      ],
    );
  }

  Widget _textMessage(bool title, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topMargin, right: latMargin, left: latMargin, bottom: topMargin),
      child: Text(
        title ? textTitle! : textQuestion!,
        style: title ? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold) : const TextStyle(fontSize: 14),
        // style: title ? Theme.of(context).dialogTheme.titleTextStyle : Theme.of(context).dialogTheme.contentTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (cancelButton)
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: _buttonSingle(true, textBtnCancel ?? TextConstant.cancelButton.text))),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: _buttonSingle(false, textBtnAccept ?? TextConstant.acceptButton.text),
          ),
        ),
      ],
    );
  }

  Widget _buttonSingle(bool cancel, String title) {
    return Container(
      decoration: BoxDecoration(
          color: cancel ? Colors.white : colorPrimary,
          border: Border.all(
            color: cancel ? Colors.white : colorPrimary,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(cancel ? 5 : cancelButton ? 0:5), bottomRight: Radius.circular(cancel ? 0 : 5))),
      height: 40,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 14.0, color: cancel ? colorPrimary : Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
