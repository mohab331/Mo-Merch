import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';

import '../../../core/utils/app_strings.dart';
import '../../domain/entities/product/product_response_entity.dart';
import '../cubit/product_description/product_description_cubit.dart';
import '../cubit/product_description/product_description_states.dart';
import '../widgets/animated_favorite_button.dart';
import '../widgets/custom_add_animated_button.dart';

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ProductDescriptionCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageRowItemBuilder(
                  productImageList: product.images ?? [product.image],
                  productId: product.id,
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.productCurrentPrice}${product.price.toStringAsFixed(1)}\$',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: context.width * 0.15,
                    ),
                    if (product.discount != 0 && product.discount != null)
                      Text(
                        '${AppStrings.productDiscount}${product.discount}%',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
                if (product.discount != 0 && product.discount != null)
                  Text(
                    '${AppStrings.productOldPrice}${product.oldPrice.toStringAsFixed(1)}\$',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                SizedBox(
                  height: context.width * 0.03,
                ),
                ExpansionTile(
                  title: Text(AppStrings.productDescription,
                      style: Theme.of(context).textTheme.bodyLarge),
                  iconColor: Theme.of(context).iconTheme.color,
                  initiallyExpanded: false,
                  collapsedIconColor: Theme.of(context).iconTheme.color,
                  subtitle: Text(
                    AppStrings.clickToExpand,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.expand_circle_down_outlined),
                  childrenPadding: const EdgeInsets.all(
                    15.0,
                  ),
                  children: [
                    Text(
                      product.description!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blue,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.15,
                ),
                BlocConsumer<ProductDescriptionCubit, ProductDescriptionStates>(
                  listener: (context, states) {
                    if (states
                        is ProductDescriptionAddOrRemoveProductFromCartSuccessState) {
                      AppFunctions.showToast(
                          message: states.message,
                          color: AppColors.successColor);
                    } else if (states
                        is ProductDescriptionToggleFavoritesState) {
                      AppFunctions.showToast(
                          message: states.message,
                          color: AppColors.successColor);
                    } else if (states is ProductDescriptionErrorState) {
                      AppFunctions.showToast(
                          message: states.message, color: AppColors.errorColor);
                    } else if (states
                        is ProductDescriptionAddOrRemoveProductFromCartErrorState) {
                      AppFunctions.showToast(
                          message: states.message,
                          color: AppColors.successColor);
                    } else {}
                  },
                  buildWhen: (previousState, currentState) {
                    return previousState != currentState &&
                        currentState is! ProductDescriptionToggleFavoritesState;
                  },
                  builder: (context, states) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomAddAnimatedButton(
                            buttonLabel: ProductDescriptionCubit.get(context)
                                .toggleButtonLabel(
                              context,
                              productId: product.id,
                            ),
                            onButtonPressed: () {
                              ProductDescriptionCubit.get(context)
                                  .addOrRemoveProductFromCart(
                                context,
                                product: product,
                              );
                            },
                          ),
                        ),
                        AnimatedFavoriteButton(
                          onButtonPressed: () {
                            ProductDescriptionCubit.get(context)
                                .toggleAddToFavorite(
                              context,
                              product: product,
                            );
                          },
                          isFavorite:
                              AppFunctions.getIsFav(context, product.id),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductImageRowItemBuilder extends StatefulWidget {
  const ProductImageRowItemBuilder({
    Key? key,
    required this.productImageList,
    required this.productId,
  }) : super(key: key);
  final int productId;
  final List<String> productImageList;

  @override
  State<ProductImageRowItemBuilder> createState() =>
      _ProductImageRowItemBuilderState();
}

class _ProductImageRowItemBuilderState
    extends State<ProductImageRowItemBuilder> {
  String? imageToDisplay;
  int selectedContainerIndex = 0;
  final TransformationController _transformationController =
      TransformationController();
  Matrix4 initialController = Matrix4.identity();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: context.width * 0.4,
            height: context.height * 0.3,
            child: InteractiveViewer(
              clipBehavior: Clip.hardEdge,
              panEnabled: false,
              transformationController: _transformationController,
              onInteractionStart: (_) {
                initialController = _transformationController.value;
              },
              minScale: 1.0,
              maxScale: 4.0,
              child: Hero(
                transitionOnUserGestures: true,
                tag: widget.productId,
                child: CachedNetworkImageBuilder(
                  imageUrl: imageToDisplay == null
                      ? widget.productImageList.first
                      : imageToDisplay!,
                  height: context.height * 0.2,
                  width: context.width * 0.2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: context.height * 0.3,
          width: context.width * 0.3,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    imageToDisplay = widget.productImageList[index];
                    selectedContainerIndex = index;
                    _transformationController.value = initialController;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: selectedContainerIndex == index
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                  child: CachedNetworkImageBuilder(
                    width: context.width * 0.1,
                    height: context.height * 0.12,
                    imageUrl: widget.productImageList[index],
                  ),
                ),
              );
            },
            itemCount: widget.productImageList.length,
          ),
        ),
      ],
    );
  }
}
