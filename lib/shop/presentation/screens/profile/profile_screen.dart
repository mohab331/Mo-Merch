import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/profile/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = 'ProfileScreen';
  static const String routePath = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<ProfileCubit>()..getUerProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            R.strings.profile,
          ),
        ),
        body: const ProfileContent(),
      ),
    );
  }
}
