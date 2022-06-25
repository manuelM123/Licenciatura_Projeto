import 'user.dart';

///this class is used to rearrange certain values obtained from JSON responses according to a specific objective
///in this case it rearranges data to be used in login function
class Data {
  final String jwt;
  final User? user;

  const Data({this.jwt = "", this.user});

  ///function that returns a object of type Data with certain values rearranged to be used in login function
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(jwt: json['jwt'], user: User.fromJson(json['user']));
  }

  @override
  String toString() {
    return "JWT: $jwt | USER: ${user.toString()}";
  }
}
