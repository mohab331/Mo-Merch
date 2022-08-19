class ChangePasswordResponse{
  bool status;
  String message;
  ChangePasswordData changePasswordData;
  ChangePasswordResponse({required this.status , required this.message , required this.changePasswordData});

}
class ChangePasswordData{
  String email;
  ChangePasswordData({required this.email});
}