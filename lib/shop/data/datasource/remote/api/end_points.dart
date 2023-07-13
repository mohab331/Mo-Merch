/// A class that provides the endpoint URLs for various API routes in the ShopApp application.
class Endpoints {
  // Endpoint URLs
  static const String login = '/login';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String favorites = '/favorites';
  static const String carts = '/carts';
  static const String logout = '/logout';
  static const String register = '/register';
  static const String search = '/products/search';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
  static const String changePassword = '/change-password';
  static const String orders = '/orders';
  static const String address = '/addresses';
  static const String productDetails = '/products';

  /// Concatenates an endpoint URL with an ID.
  ///
  /// This method is useful when you need to construct an endpoint URL
  /// that requires an ID parameter, such as fetching a specific resource.
  /// The [endPoint] parameter represents the base endpoint URL,
  /// and the [id] parameter represents the ID value to be appended to the URL.
  ///
  /// Example usage:
  /// ```
  /// String productEndpoint = Endpoints.concatenateEndPoint(endPoint: '/products', id: 123);
  /// // Result: '/products/123'
  /// ```
  static String concatenateEndPoint({
    required String endPoint,
    required int id,
  }) {
    return '$endPoint/$id';
  }
}
