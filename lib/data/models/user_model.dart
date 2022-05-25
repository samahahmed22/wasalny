class UserModel {
  String id;
  String? firstName;
  String? lastName;
  String? email;
  String phoneNumber;
  String? imageUrl;

  UserModel(
      {required this.id,
      this.firstName,
      this.lastName,
      this.email,
      required this.phoneNumber,
      this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      phoneNumber: jsonData['phone'],
      imageUrl: jsonData['imageUrl'],
    );
  }
  toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
