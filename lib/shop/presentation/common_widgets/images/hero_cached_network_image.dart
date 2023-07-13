import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/images/cached_network_image.dart';

class HeroCachedNetworkImage extends StatelessWidget {
  const HeroCachedNetworkImage({
    required this.id,
    required this.imageHeight,
    required this.imageUrl,
    this.imageWidth,
    this.imageFit,
    Key? key,
  }) : super(key: key);
  final int id;
  final double imageHeight;
  final double? imageWidth;
  final String imageUrl;
  final BoxFit? imageFit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: id,
      child: CachedNetworkImageBuilder(
        height: imageHeight.h,
        width: imageWidth?.w ?? double.infinity,
        imageUrl: imageUrl,
        imageFit: imageFit,
      ),
    );
  }
}
