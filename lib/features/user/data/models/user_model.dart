import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    required String phoneNumber,
    String? imageUrl,
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            imageUrl: imageUrl);

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
