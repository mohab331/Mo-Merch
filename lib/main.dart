import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/service_locators/index.dart';
import 'package:shop_app_clean_architecture/shop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  Bloc.observer = AppBlocObserver();
  runApp(
    const ShopApp(),
  );
}
