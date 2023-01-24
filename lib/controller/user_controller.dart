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

        // loginStatusCheck();
      }
      return;
    } catch (e) {
      Get.snackbar('Firebase error', e.toString());
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    await auth.signOut();
    final storage = GetStorage();
    storage.remove('id');
    storage.remove('email');
    storage.remove('username');
    isLoggedIn.value = false;
  }

  loginStatusCheck() async {
    final curUser = auth.currentUser;
    if (curUser != null) {
      // load user data from cache
      final storage = GetStorage();
      final id = await storage.read('id');
      final email = await storage.read('email');
      final username = await storage.read('username');
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

      // load all data needed
      ClientApi.getAllProducts();
      ClientApi.getCategories();
      ClientApi.getMyProducts();

      // change logged in status
      isLoggedIn.value = true;
    }
  }

  changeLoggedInUser(Users param) {
    user(param);
    final storage = GetStorage();
    storage.write('id', param.id);
    storage.write('email', param.email);
    storage.write('username', param.username);

    ClientApi.getAllProducts();
    ClientApi.getCategories();
    ClientApi.getMyProducts();

    isLoggedIn.value = true;
  }
}
