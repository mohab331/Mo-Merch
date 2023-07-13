import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
    );
  }
}
