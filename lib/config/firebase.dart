import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

firebaseInit() async {
  bool isWeb = kIsWeb;
  if (isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBQFrEb4qWQ97rpMY3eGkTG5E_MQtoGPzY",
        projectId: "quizapp-56805",
        messagingSenderId: "346090743951",
        appId: "1:346090743951:web:0812d6285641bd961d68fa",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
}

/**
 * 
 * // Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBQFrEb4qWQ97rpMY3eGkTG5E_MQtoGPzY",
  authDomain: "quizapp-56805.firebaseapp.com",
  databaseURL: "https://quizapp-56805-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "quizapp-56805",
  storageBucket: "quizapp-56805.appspot.com",
  messagingSenderId: "346090743951",
  appId: "1:346090743951:web:0812d6285641bd961d68fa",
  measurementId: "G-9GZSPCXPWF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
 */