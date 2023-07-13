import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';

class BannerCarousel extends StatelessWidget {
  BannerCarousel({
    required this.banners,
    super.key,
  });
  final CarouselController carouselController = CarouselController();
  final List<BannersResponseEntity> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map(
            (e) => CachedNetworkImageBuilder(
              imageUrl: e.image,
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 250.0.h,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(
          seconds: 3,
        ),
        autoPlay: true,
      ),
      carouselController: carouselController,
    );
  }
}
