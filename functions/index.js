const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.myFunction = functions.firestore.document('offers/{offer}')
.onCreate((snapshot,context) => {
//console.log(snapshot.data());

return admin.messaging().sendToTopic('offers',{notification: {
title: 'New Offer',
body: snapshot.data().description,
clickAction : 'FLUTTER_NOTIFICATION_CLICK',
}});
});


exports.myFunctionP = functions.firestore.document('properties/{offer}')
.onCreate((snapshot,context) => {
//console.log(snapshot.data());

return admin.messaging().sendToTopic('offers',{notification: {
title: snapshot.data().title,
body: snapshot.data().description,
clickAction : 'FLUTTER_NOTIFICATION_CLICK',
}});
});

