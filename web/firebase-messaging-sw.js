// Import and configure the Firebase SDK
// These scripts are made available when the app is served or deployed on Firebase Hosting
// If you do not serve/host your project using Firebase Hosting see https://firebase.google.com/docs/web/setup
importScripts('/__/firebase/9.2.0/firebase-app-compat.js');
importScripts('/__/firebase/9.2.0/firebase-messaging-compat.js');
importScripts('/__/firebase/init.js');
importScripts('https://www.gstatic.com/firebasejs/9.2.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.2.0/firebase-messaging-compat.js');
//  Here is is the code snippet to initialize Firebase Messaging in the Service
//   Worker when your app is not hosted on Firebase Hosting.

 // Give the service worker access to Firebase Messaging.
 // Note that you can only use Firebase Messaging here. Other Firebase libraries
 // are not available in the service worker.


 // Initialize the Firebase app in the service worker by passing in
 // your app's Firebase config object.
 // https://firebase.google.com/docs/web/setup#config-object

   const firebaseConfig = {
      apiKey: "AIzaSyBxixSwX0dOWs2kd3pY4xkfGNHjE8ZuYaE",
      authDomain: "pos-admin-pannel.firebaseapp.com",
      projectId: "pos-admin-pannel",
      storageBucket: "pos-admin-pannel.appspot.com",
      messagingSenderId: "729150149298",
      appId: "1:729150149298:web:219f3a9d103e702eea2fab",
      measurementId: "G-EVFR4HVDPB"
    };
firebase.initializeApp(firebaseConfig);
 const messaging = firebase.messaging();
messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = 'Background Message Title';
  const notificationOptions = {
    body: 'Background Message body.',
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});