import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/screens/product_list_page.dart';
import 'package:simple_store/screens/profile_page.dart';
import 'package:simple_store/screens/user_product_page.dart';
import 'package:simple_store/widget/custom_rounded_button.dart';
import 'package:simple_store/widget/dialog_yes_no.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UserProductPage(),
                  ),
                );
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Product list',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onLogoutTapped();
              },
              child: const Card(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogoutTapped() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogYesNo(
            onYes: () {
              Provider.of<ProviderUser>(context, listen: false).doLogout();
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const ProductListPage(),
                  ),
                  (Route<dynamic> route) => false);
            },
            title: 'Are you want to logout?');
      },
    );
  }
}
