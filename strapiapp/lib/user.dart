///this class is used to rearrange certain values obtained from JSON responses according to a specific objective
///in this case it rearranges data to be used in Data class
class User {
  final int? id;
  final String? username;
  final String? email;
  final bool? confirmed;
  final String? createdAt;
  final String? updatedAt;

  const User(
      {this.id,
      this.username,
      this.email,
      this.confirmed,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        confirmed: json['confirmed'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  @override
  String toString() {
    return "[ID: $id | Username: $username | Email: $email | Confirmed: $confirmed | Created: $createdAt | Updated: $updatedAt]";
  }
}
