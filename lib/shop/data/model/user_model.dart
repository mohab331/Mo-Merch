import 'package:shop_app_clean_architecture/shop/domain/entities/user.dart';

class UserModel extends User {
  UserModel._(
      {required super.id,
      required super.name,
      required super.image,
      required super.credit,
      required super.token,
      required super.email,
      required super.points,
      required super.phone});
  factory UserModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      UserModel._(
          id: jsonMap['id'],
          name: jsonMap['name'],
          image: jsonMap['image'],
          credit: jsonMap['credit'],
          token: jsonMap['token'],
          email: jsonMap['email'],
          points: jsonMap['points'],
          phone: jsonMap['phone']);
}
