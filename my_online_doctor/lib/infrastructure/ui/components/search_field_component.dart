//Package imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

///SearchFieldComponent: Component that shows a search field.
///
///[onSubmitted]: Function that is called when the text in the search field changes.
///[hintText]: Text to show in the search field as hint text.
///[textInputType]: The text in the search field that has been added by the user.
class SearchFieldComponent extends StatefulWidget {
  final String text;
  final ValueChanged<String> onSubmitted;
  final String hintText;

  const SearchFieldComponent({
    Key? key,
    required this.text,
    required this.onSubmitted,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchFieldComponentState createState() => _SearchFieldComponentState();
}

class _SearchFieldComponentState extends State<SearchFieldComponent> {
  final _searchController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    getIt<ContextManager>().screenSize = MediaQuery.of(context).size;

    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: getIt<ContextManager>().screenSize.height * 0.075,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorWhite,
        border: Border.all(color: colorPrimary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    _searchController.clear();
                    widget.onSubmitted('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}