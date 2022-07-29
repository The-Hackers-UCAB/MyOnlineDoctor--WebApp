import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

///ShowErrorComponent: Component that shows an error image with the right configuration.

///[errorImagePath]: Path of the error image to use.
class ShowErrorComponent extends StatefulWidget {

final String errorImagePath;

  const ShowErrorComponent({
    Key? key,
    required this.errorImagePath,
  }) : super(key: key);

  @override
  State<ShowErrorComponent> createState() => _ShowErrorComponentState();
}

class _ShowErrorComponentState extends State<ShowErrorComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        widget.errorImagePath, 
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6, 
      ),
    );
  }
}