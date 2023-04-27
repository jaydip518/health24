import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthServices {
  static Future<UserCredential?> signUpUser(
      {String? email, String? password,String? name}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('SIGN UP ERRRO++>>${e.message}');
    }
  }

  static Future<UserCredential?> loginUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('SIGN IN ERRRO++>>${e.message}');
    }
  }

  static Future logOut() async {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print('SIGN OUT ERRRO++>>${e.message}');
    }
  }
  static Future ForgetUser({
    String? email,
  }) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      print('SIGN IN Forget++>>${e.message}');
    }
  }
}
