import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class CachedNetworkImageBuilder extends StatelessWidget {
  const CachedNetworkImageBuilder({
    required this.imageUrl,
    this.width,
    this.height,
    this.imageFit,
    Key? key,
  }) : super(key: key);
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? imageFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit:imageFit ?? BoxFit.contain,
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: R.colors.darkGrey,
        highlightColor: R.colors.mediumGrey,
        child: Container(
          decoration: BoxDecoration(
            color: R.colors.blackColor,
            borderRadius: BorderRadius.circular(8.0.r),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
    );
  }
}
