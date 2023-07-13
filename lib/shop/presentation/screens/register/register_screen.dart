import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/register/index.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = 'RegisterScreen';
  static const routePath = '/RegisterScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const RegisterContent(),
    );
  }
}
