const functions = require("firebase-functions/v1");
const admin = require("firebase-admin" );
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

exports.notifyClient = functions.firestore.document("orders/{orderId}")
    .onUpdate(async (change, context) => {
      const db = admin.firestore();
      const newValue = change.after.data();
      const oldValue = change.before.data();

      const title = "Status";
      const text = "of order has changed to: " + newValue.status;
      let userToken = "";

      // Check if the status field has changed
      if (newValue.status !== oldValue.status) {
        const userID = newValue.userID;
        console.log("UserID is ");
        console.log(userID);
        try {
          const userDoc = await db.collection("users").doc(userID).get();
          const token = userDoc.data().token;
          userToken = token;
          console.log("User token is ");
          console.log(userToken);
        } catch (error) {
          console.log("Error was catched on line 22");
          console.log(error);
        }
        const message = {
          notification: {
            title: title,
            body: text,
          },
          token: userToken,
        };
        admin.messaging().send(message)
            .then((responce) => {
              console.log(responce);
            })
            .catch((error) => {
              console.log(error);
            });
      }
    });
