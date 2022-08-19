import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  const AnimatedFavoriteButton({Key? key,required this.onButtonPressed,required this.isFavorite,}) : super(key: key);
  final Function onButtonPressed;
  final bool isFavorite;

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    _isFavorite = widget.isFavorite;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavorite = !widget.isFavorite;
        });
        widget.onButtonPressed();
        _controller
            .reverse()
            .then((value) => _controller.forward());
      },
      child: ScaleTransition(
        scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: _isFavorite
            ? const Icon(
          Icons.favorite,
          size: 35,
          color: AppColors.loveColor,
        )
            : const Icon(
          Icons.favorite_border,
          size: 35,
          color: Colors.grey,
        ),
      ),
    );
  }
}