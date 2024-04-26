import 'package:flutter/material.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';

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
          backgroundColor: AppColors.minglWhite,
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
