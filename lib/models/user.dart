import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class User {
  final String id;
  final String name;
  final String email;
  final int age;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.name == name && other.email == email && other.age == age;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ age.hashCode;
  }
}
