import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({required this.currentIndex , Key? key}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      borderRadius: 40.0.r,
      backgroundColor: Colors.grey[200],
      marginR: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 700,),
      items: [
        DotNavigationBarItem(
          icon: const Icon(
            Icons.home,
          ),
        ),
        DotNavigationBarItem(
          icon: const Icon(
            Icons.search,
          ),
        ),
        DotNavigationBarItem(
          icon:  Icon(
            Icons.favorite_rounded,
            color: Colors.red[900],
          ),
        ),
      ],
      onTap: (index) => context.read<ShopCubit>().toggleIndex(
        index,
      ),
      currentIndex: currentIndex,
    );
  }
}
