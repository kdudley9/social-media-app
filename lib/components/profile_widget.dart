import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_image_provider.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';
import 'package:social_media_app/shared_assets/image_assets.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        Provider.of<ProfileImageProvider>(context).profileImageUrl;

    return Center(
      child: Stack(
        children: [
          buildImage(imageUrl),
          if (isEdit)
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(AppColors.minglRed),
            )
        ],
      ),
    );
  }

  Widget buildImage(String imageUrl) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageUrl.isEmpty
              ? const AssetImage(ImageAssets.defaultProfilePicture)
                  as ImageProvider
              : NetworkImage(imageUrl),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle(
          {required Color color, required double all, required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
