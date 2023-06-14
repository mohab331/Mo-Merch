class UserResponseEntity {
  const UserResponseEntity({
    required this.id,
    required this.name,
    required this.credit,
    required this.token,
    required this.email,
    required this.points,
    required this.phone,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final int points;
  final double credit;
  final String token;
}
