import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/home/cubit/home_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/home/cubit/home_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/home/widgets/index.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;
    print('Rebuild Home Screen');
    return SafeArea(
      child: StateHandlingWidget(
        isLoading: state is HomeDataLoadingState || context.watch<AppCubit>().state is AppLoadingDataState,
        hasError: state is HomeDataErrorState,
        successWidget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerCarousel(
                  banners: (state is HomeDataSuccessState)
                      ? state.homeResponseEntity.banners
                      : [],
                ),
                SizedBox(
                  height: 40.h,
                ),
                ProductGridView(
                  products: (state is HomeDataSuccessState)
                      ? state.homeResponseEntity.products
                      : [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
