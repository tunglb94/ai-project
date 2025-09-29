import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final bool isActive; // Đảm bảo trường này đã có

  const UserEntity({
    required this.id,
    required this.email,
    required this.isActive, // Đảm bảo constructor có tham số này
  });

  @override
  List<Object?> get props => [id, email, isActive];
}