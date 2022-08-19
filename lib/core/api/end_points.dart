class Endpoints {
  static const String login = 'login';
  static const String home = 'home';
  static const String categories = 'categories';
  static const String favorites = 'favorites';
  static const String carts = 'carts';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String search = 'products/search';
  static const String profile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String changePassword = 'change-password';
  static const String orders = 'orders';
  static const String address = 'addresses';

  static String concatenateEndPoint({required String endPoint,required int id}){
    return '$endPoint/$id';
  }
}
