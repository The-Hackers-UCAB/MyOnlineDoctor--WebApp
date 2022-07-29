import 'package:flutter/widgets.dart';

///ImageViewComponent: Class that manages the UI image view.
class ImageViewComponent extends StatelessWidget {
  final String image;

  // ignore: use_key_in_widget_constructors
  const ImageViewComponent(this.image);

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(image));
  }
}