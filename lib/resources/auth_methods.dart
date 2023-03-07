import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => auth.authStateChanges();
  User get user => auth.currentUser!;

  Future<bool> signInWIthGoggle(context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'phone': user.phoneNumber,
            'photo': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(context, e.message!);
    }
    return res;
  }

  signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message!);
    }
  }
}
