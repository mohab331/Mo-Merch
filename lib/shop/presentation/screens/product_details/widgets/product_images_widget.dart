import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductImagesWidget extends HookWidget {
  const ProductImagesWidget({
    required this.product,
    super.key,
  });
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    final imageToDisplay = useState(product.image);
    final selectedImageIndex = useState(-1);
    final transformController = useTransformationController();
    Matrix4 initialController = Matrix4.identity();
    return Column(
      children: [
        InteractiveProductImage(
          transformationController: transformController,
          initialController: initialController,
          product: product,
          imageSelected: imageToDisplay.value,
        ),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleOnImageTapped(
                  imageToDisplay,
                  index,
                  selectedImageIndex,
                  transformController,
                  initialController,
                ),
                child: SelectedImageWidget(
                  imageToDisplay: product.images?[index] ?? '',
                  isSelected: (selectedImageIndex.value == index),
                ),
              );
            },
            itemCount: product.images?.length,
            physics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }

  void _handleOnImageTapped(
    ValueNotifier<String> imageToDisplay,
    int index,
    ValueNotifier<int> selectedImageIndex,
    TransformationController transformController,
    Matrix4 initialController,
  ) {
    imageToDisplay.value = product.images?[index] ?? product.image;
    selectedImageIndex.value = index;
    transformController.value = initialController;
  }
}

class InteractiveProductImage extends StatelessWidget {
  InteractiveProductImage({
    required this.imageSelected,
    required this.transformationController,
    required this.initialController,
    required this.product,
    Key? key,
  }) : super(key: key);
  final TransformationController transformationController;
  Matrix4 initialController;
  final ProductResponseEntity product;
  final String imageSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 300.h,
      child: InteractiveViewer(
        panEnabled: false,
        transformationController: transformationController,
        onInteractionStart: (_) {
          initialController = transformationController.value;
        },
        minScale: 1.0,
        maxScale: 4.0,
        child: HeroCachedNetworkImage(
          imageHeight: 20.h,
          imageUrl: imageSelected,
          id: product.id,
          imageWidth: 30.w,
          imageFit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SelectedImageWidget extends StatelessWidget {
  const SelectedImageWidget({
    required this.imageToDisplay,
    required this.isSelected,
    Key? key,
  }) : super(key: key);
  final String imageToDisplay;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        10.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isSelected ? R.colors.primaryColor : R.colors.greyColor,
        ),
      ),
      child: CachedNetworkImageBuilder(
        width: 100.w,
        height: 100.h,
        imageUrl: imageToDisplay,
        imageFit: BoxFit.contain,
      ),
    );
  }
}
