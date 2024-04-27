import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String message;
  final String user;
  final String time;

  const Comment({
    super.key,
    required this.message,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Add spacing between comments
      padding: const EdgeInsets.all(10), // Consistent padding
      decoration: BoxDecoration(
        color: Colors.grey[100], // Lighter background for contrast
        borderRadius: BorderRadius.circular(8), // Slightly rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Subtle shadow for depth
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
        children: [
          Text(
            user,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, // Slightly smaller size for usernames
            ),
          ),
          const SizedBox(height: 4), // Space between user and message
          Text(
            message,
            style: const TextStyle(
              fontSize: 16, // Default size for comment message
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6), // Space between message and timestamp
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time, // Icon for timestamp
                size: 14, // Smaller icon size
              ),
              const SizedBox(width: 4), // Space between icon and time
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey, // Light gray for timestamp
                  fontSize: 12, // Smaller size for timestamp
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
