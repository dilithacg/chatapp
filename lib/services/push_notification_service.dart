import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initialize(String userId) async {
    // Request permission for iOS devices
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Get the FCM token
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        // Save the token to Firestore
        await _firestore.collection('users').doc(userId).set({
          'fcmToken': token,
        }, SetOptions(merge: true));
      }
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
