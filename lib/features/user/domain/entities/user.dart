import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  String? firstName;
  String? lastName;
  String? email;
  final String phoneNumber;
  String? imageUrl;

  User(
      {required this.id,
      this.firstName,
      this.lastName,
      this.email,
      required this.phoneNumber,
      this.imageUrl});

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, phoneNumber, imageUrl];
}
