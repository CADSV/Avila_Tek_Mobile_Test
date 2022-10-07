//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/image_view_component.dart';

//Widget for rendering images
Widget renderImageView(BuildContext context, String path) => Container(
    margin:const  EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
    height: MediaQuery.of(context).size.height *  0.6,
    width: double.infinity,
    child: ImageViewComponent(path));