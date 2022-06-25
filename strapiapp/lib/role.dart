// ignore_for_file: non_constant_identifier_names

///this class is used to rearrange certain values obtained from JSON responses according to a specific objective
///in this case it rearranges data to be used in getIDRole function
class Role {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? createdAt;
  final String? updatedAt;
  final int? nb_users;

  const Role(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.nb_users});

  ///function that returns a object of type Role with certain values rearranged to be used in getIDRole function
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        type: json['type'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        nb_users: json['nb_users']);
  }

  @override
  String toString() {
    return "[ID: $id | Name: $name | Description: $description | Type: $type | Created: $createdAt | Updated: $updatedAt] | Number of Users: $nb_users]";
  }
}
