import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String message;
  final String user;
  final String profilePhotoUrl;

  const Post({
    super.key,
    required this.message,
    required this.user,
    required this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profilePhotoUrl),
        ),
        Column(
          children: [
            Text(user),
            Text(message),
          ],
        )
      ],
    );
  }
}
