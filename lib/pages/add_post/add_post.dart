import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/pages/home/home_content.dart';
import 'package:social_media_app/services/posts_service.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:social_media_app/nav.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final PostsService postsService = PostsService();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _messageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message';
                      }
                      return null;
                    },
                    maxLines: 6,
                    minLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insert your message...',
                    ),
                    maxLength: 250,
                    scrollPadding: EdgeInsets.all(20.0),
                    autofocus: true,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.minglRed),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.minglWhite),
                        fixedSize:
                            MaterialStateProperty.all(const Size(100, 40)),
                      ),
                      onPressed: () async {
                        String message = _messageController.text.trim();
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          await postsService.addPost(message);
                          _messageController.clear();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeContent()),
                          );
                        }
                      },
                      child: const Text('Post'),
                    ),
                    const SizedBox(width: 25),
                    OutlinedButton(
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(100, 40)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeContent()),
                        );
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
