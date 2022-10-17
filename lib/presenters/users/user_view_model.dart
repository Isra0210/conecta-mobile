import 'package:equatable/equatable.dart';

class UserViewModel implements Equatable {
  const UserViewModel({
    required this.id,
    required this.name,
    required this.isAdmin,
  });

  final String id;
  final String name;
  final bool isAdmin;

  factory UserViewModel.fromMap(Map<String, dynamic> map) {
    return UserViewModel(
      id: map['uid'].toString(),
      name: map['name'],
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': id, 'name': name, 'isAdmin': isAdmin};
  }

  @override
  List<Object?> get props => [id, name, isAdmin];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return "name: $name isAdmin: $isAdmin";
  }
}
