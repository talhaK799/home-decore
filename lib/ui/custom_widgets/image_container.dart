import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:flutter/cupertino.dart';

class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final voidFunction? onPressed;
  final BoxFit? fit;

  ImageContainer(
      {this.height, this.width, this.image, this.onPressed, this.fit});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$image'),
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }
}
