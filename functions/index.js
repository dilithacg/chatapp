
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.sendPushNotification = functions.firestore
  .document("messages/{messageId}")
  .onCreate(async (snap, context) => {
    const newMessage = snap.data();
    const receiverId = newMessage.receiver;

    // Fetch the FCM token of the receiver from Firestore
    const userDoc = await db.collection("users").doc(receiverId).get();

    if (!userDoc.exists) {
      console.log("No user found with the ID:", receiverId);
      return;
    }

    const userData = userDoc.data();
    const fcmToken = userData.fcmToken;

    if (!fcmToken) {
      console.log("No FCM token for the user:", receiverId);
      return;
    }

    const payload = {
      notification: {
        title: "New Message from " + newMessage.sender,
        body: newMessage.message,
        sound: "default",
      },
      data: {
        senderId: newMessage.sender,
        message: newMessage.message,
      },
    };

    try {
      // Send a push notification
      await admin.messaging().sendToDevice(fcmToken, payload);
      console.log("Push notification sent successfully!");
    } catch (error) {
      console.log("Error sending push notification:", error);
    }
  });
