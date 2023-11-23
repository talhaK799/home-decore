import 'package:flutter/material.dart';

/// ImageContainer creates container with specific height and width
/// and use Image as backgroung image of the container
class ImageContainer extends StatelessWidget {
  final double? height, width;
  final String? assetImage;
  final fit;
  ImageContainer({this.height, this.fit, this.width, this.assetImage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetImage!),
          fit: fit ?? null,
        ),
      ),
    );
  }
}
