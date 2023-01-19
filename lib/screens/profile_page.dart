import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/models/users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoaded = false;
  Users? user;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    // _loadData();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      if (event != null) {
        getContact(event);
        print('====== any account');
      } else {
        print('====== null account');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Profile'),
      ), */
      body: isLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  user!.username!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user!.email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          : SizedBox(
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _googleSignIn.signIn();
                    bool isSigned = await _googleSignIn.isSignedIn();
                    if (isSigned) {
                      print(_googleSignIn.currentUser!.displayName);
                    }
                  },
                  child: const Text('Login with google'),
                ),
              ),
            ),
    );
  }

  void _loadData() {
    bool isLoggedIn = Provider.of<ProviderUser>(context).getStatusLogin();
    if (isLoggedIn) {
      user = Provider.of<ProviderUser>(context, listen: false).user;
      isLoaded = true;
      setState(() {});
    }
  }

  void getContact(GoogleSignInAccount account) {
    print(account.displayName);
  }
}
