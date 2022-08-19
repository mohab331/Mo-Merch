class LogoutResponse{
  bool status;
  String message;
  LogoutData logoutData;
  LogoutResponse({required this.status , required this.message , required this.logoutData});
}
class LogoutData{
  int id;
  String token;
  LogoutData({required this.id , required this.token});
  }
