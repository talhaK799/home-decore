const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotificationToAllUsers = functions.firestore
    .document('notifications/{id}')
    .onCreate(async (snapshot, context) => {
        const notificationData = snapshot.data();

        const payload = {
            notification: {
                title: notificationData.title,
                body: notificationData.content,
                icon: notificationData.imageUrl, // Set the URL to the icon you want to display
            },
        };

        try {
            const usersSnapshot = await admin.firestore().collection('app_user').get();

            const tokens = [];
            usersSnapshot.forEach((userDoc) => {
                const userData = userDoc.data();
                if (userData.fcm_token) {
                    console.log("user fcm token=====>" + userData.fcm_token);
                    if (userData.fcm_token != null) {

                        tokens.push(userData.fcm_token);
                    }
                }
            });

            if (tokens.length > 0) {
                await admin.messaging().sendToDevice(tokens, payload);
                console.log('Notification sent to all users.');
            } else {
                console.log('No users with FCM tokens found.');
            }

            return null;
        } catch (error) {
            console.error('Error sending notification:', error);
            return null;
        }
    });
