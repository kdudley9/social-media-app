import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();

  String formattedData = "$month/$day/$year";

  return formattedData;
}

String timeAgo(Timestamp timestamp) {
  final now = DateTime.now();
  final postDate = timestamp.toDate();
  final difference = now.difference(postDate);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  }
}