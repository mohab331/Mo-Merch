import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/app_bloc_observer.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  await Firebase.initializeApp();
  await diInstance.get<NotificationRepo>().initializeConfig();
  Bloc.observer = AppBlocObserver();
  runApp(
    const ShopApp(),
  );
}
