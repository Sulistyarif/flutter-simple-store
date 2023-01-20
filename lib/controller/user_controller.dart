import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/users.dart';

class UserController extends GetxController {
  final user = Users().obs;
  final isLoggedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await auth.signInWithCredential(credential);

      final User? user = authResult.user;
      if (user != null) {
        assert(!user.isAnonymous);
        // assert(await user.getIdToken() != null);
        final User? currentUser = auth.currentUser;
        assert(user.uid == currentUser!.uid);
        isLoggedIn.value = true;
      }
      return;
    } catch (e) {
      Get.snackbar('Firebase error', e.toString());
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    isLoggedIn.value = false;
  }
}
