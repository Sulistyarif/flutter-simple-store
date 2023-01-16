import 'package:flutter/material.dart';
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

  /* @override
  void initState() {
    _loadData();
    super.initState();
  } */

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
          : const SizedBox(),
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
}
