//Package imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';


///BaseUIComponent: Class that manages the UI base page.
class BaseUIComponent extends StatefulWidget {
  PreferredSizeWidget? appBar;
  final Widget body;
  Color? backgroundColor;
  Widget? bottomNavigationBar;

  BaseUIComponent(
      {this.appBar,
        required this.body,
        this.backgroundColor,
        this.bottomNavigationBar});

  @override
  State<StatefulWidget> createState() => _BaseUIComponent();
}
class _BaseUIComponent extends State<BaseUIComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: Context issue :(
    final Color bgColor = widget.backgroundColor ?? colorWhite;
    return Scaffold(
        appBar: widget.appBar,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(child: widget.body)),
        backgroundColor: bgColor,
        bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
