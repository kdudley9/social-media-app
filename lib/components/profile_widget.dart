import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';
import 'package:social_media_app/shared_assets/image_assets.dart';

class ProfileWidget extends StatelessWidget {
  final String userId;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.onClicked,
    this.isEdit = false,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final imageUrl =
            userData['imagePath'] ?? ImageAssets.defaultProfilePicture;

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
      },
    );
  }

  Widget buildImage(String imageUrl) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageUrl.isEmpty
              ? NetworkImage(ImageAssets.defaultProfilePicture)
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

  Widget _buildPlaceholder() {
    return Container(
      width: 128,
      height: 128,
      child: Center(
        child: Icon(
          Icons.account_circle,
          size: 80,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
