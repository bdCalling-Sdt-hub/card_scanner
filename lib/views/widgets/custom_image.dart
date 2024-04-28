import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType{
  png,
  svg,
}

class CustomImage extends StatelessWidget {

  final String imageSrc;
  final Color? imageColor;
  final double? size;
  final ImageType imageType;
  final BoxFit fill;

  CustomImage({

    required this.imageSrc,
    this.imageColor ,
    this.size,
    this.imageType = ImageType.svg,
    this.fill = BoxFit.contain,
    super.key,
  });

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {

    if(imageType == ImageType.svg){
      imageWidget = SvgPicture.asset(
        imageSrc,
        color: imageColor,
        height: size, width: size,
        fit: fill,
      );
    }

    if(imageType == ImageType.png){
      imageWidget = Image.asset(
        imageSrc,
        color: imageColor,
        height: size, width: size,
        fit: fill,

      );
    }

    return SizedBox(
        height: size, width: size,
        child: imageWidget
    );
  }
}