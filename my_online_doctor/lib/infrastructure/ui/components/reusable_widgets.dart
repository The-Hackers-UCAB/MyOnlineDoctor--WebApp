import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/core/constants/image_constants.dart';

import 'image_view_component.dart';

Widget renderLogoImageView(BuildContext context, {bool fullLogo = false}) => Container(
    margin: EdgeInsets.only(left: 20, top: (fullLogo ? 0 : 10), right: 20, bottom: (fullLogo ? 0 : 10)),
    height: MediaQuery.of(context).size.width *  (fullLogo ? 0.6 : 0.4),
    width: double.infinity,
    child: ImageViewComponent(fullLogo ? ImagesConstant.fullLogo.image : ImagesConstant.logo.image));


Widget heightSeparator(BuildContext context, double heightPercentage) => SizedBox(
      height: MediaQuery.of(context).size.height * heightPercentage,
    );
  