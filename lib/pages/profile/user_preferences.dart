import 'package:social_media_app/components/user.dart';
import 'package:social_media_app/shared_assets/image_assets.dart';

class UserPreferences {
  static const myUser = User(
    id: '',
    imagePath: ImageAssets.defaultProfilePicture,
    name: 'Jane Doe',
    email: 'janedoe@email.com',
    bio:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  );
}
