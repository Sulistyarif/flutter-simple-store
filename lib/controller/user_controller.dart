import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_store/api/client_api.dart';

import '../models/users.dart';

class UserController extends GetxController {
  final user = Users().obs;
  final isLoggedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  loginWithGoogle(context) async {
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
        final User? currentUser = auth.currentUser;
        assert(user.uid == currentUser!.uid);

        // create or login user
        ClientApi.loginOrRegister(
            user.displayName, 'password', user.email, context);

        isLoggedIn.value = true;
      }
      return;
    } catch (e) {
      Get.snackbar('Firebase error', e.toString());
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    await auth.signOut();
    isLoggedIn.value = false;
  }

  loginStatusCheck() {
    final curUser = auth.currentUser;
    if (curUser != null) {
      isLoggedIn.value = true;
      final storage = GetStorage();
      final id = storage.read('id');
      final email = storage.read('email');
      final username = storage.read('username');
      Users newUser = Users(
        createdAt: '',
        email: email,
        id: id,
        password: '',
        updatedAt: '',
        username: username,
        name: username,
      );
      user(newUser);
    }
  }

  changeLoggedInUser(Users param) {
    user(param);
    final storage = GetStorage();
    storage.write('id', param.id);
    storage.write('email', param.email);
    storage.write('username', param.username);
  }
}
