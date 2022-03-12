import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final Color color;
  final void Function() onTap;
  const UserCard({
    Key? key,
    required this.user,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(user.name.toUpperCase().substring(0, 1)),
      ),
    );
  }
}
