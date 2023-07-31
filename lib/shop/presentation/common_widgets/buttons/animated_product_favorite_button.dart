import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class AnimatedProductFavoriteButton extends HookWidget {
  const AnimatedProductFavoriteButton({
    required this.product,
    required this.showToastOnFavoriteToggle,
    this.iconSize,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity product;
  final bool showToastOnFavoriteToggle;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final favoriteCubit = context.read<FavoriteCubit>();
    final animationController = useAnimationController(
      duration: const Duration(
        milliseconds: 200,
      ),
      initialValue: 1,
    );
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state.message != null) {
          final toastColor = state is FavoriteToggleSuccessState
              ? R.colors.greenColor
              : R.colors.redColor;
          R.functions.showToast(
            message: state.message ?? '',
            color: toastColor,
          );
        }
      },
      listenWhen: (previousState, currentState) {
        return (previousState.runtimeType != currentState.runtimeType) && (showToastOnFavoriteToggle) &&
            (currentState is FavoriteToggleSuccessState ||
                currentState is FavoriteToggleErrorState);
      },
      buildWhen: (_, currentState) {
        return currentState is InstantToggleState ||
            currentState is FavoriteToggleErrorState;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _onButtonTapped(
              favoriteCubit,
              appCubit,
            );
            animationController.reverse().then(
                  (value) => animationController.forward(),
                );
          },
          child: ScaleTransition(
            scale: Tween(begin: 0.7, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOut,
              ),
            ),
            child: appCubit.isInFavoriteMap(
              id: product.id,
            )
                ? Icon(
                    Icons.favorite,
                    size: 30,
                    color: R.colors.redColor,
                  )
                : Icon(
                    Icons.favorite_border,
                    size: iconSize ?? 40,
                    color: R.colors.greyColor,
                  ),
          ),
        );
      },
    );
  }

  void _onButtonTapped(FavoriteCubit favoriteCubit, AppCubit appCubit) {
    favoriteCubit.toggleFavorite(
      appCubit,
      product: product,
    );
  }
}
