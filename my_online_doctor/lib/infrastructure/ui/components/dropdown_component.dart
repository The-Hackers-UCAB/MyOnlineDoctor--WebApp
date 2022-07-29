import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/theme.dart';

class DropdownComponentModel {
  List<String>? dropDownLists;
  late String itemDropdownSelected;

  DropdownComponentModel(
      {required this.dropDownLists, required this.itemDropdownSelected});
}

class DropdownComponent extends StatelessWidget {
  final DropdownComponentModel model;
  final ValueChanged? didChangeValue;

  const DropdownComponent({Key? key, required this.model, this.didChangeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 60,
        decoration: boxDecorationDropdown(false, false),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            iconEnabledColor: colorPrimary,
            iconDisabledColor: colorPrimary,
            value: model.itemDropdownSelected,
            items: model.dropDownLists
                ?.map((e) => DropdownMenuItem(
                    value: e, child: _dropDownItem(e, context)))
                .toList(),
            onChanged: didChangeValue,
          ),
        ),
      );

  Widget _dropDownItem(String item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Center(
          child: Text(
        item,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: colorBlack, fontSize: 16, fontWeight: FontWeight.normal),
      )),
    );
  }
}
