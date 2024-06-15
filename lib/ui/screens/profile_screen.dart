import 'package:flood/data/models/login_model.dart';
import 'package:flood/data/utils/auth_utils.dart';
import 'package:flood/ui/screens/auth/login_screen.dart';
import 'package:flood/ui/screens/auth/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Data userInfo = AuthUtility.userInfo.data!;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
              children: [
                Image.network(
                    "https://avatar.iran.liara.run/public/37",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover, // Optional, to control the image fitting
                  ),
                const SizedBox(height: 10),
                Text("${userInfo.name ?? " "}", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red.shade700),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hemogoblin", style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(height: 4),
                          Text("${userInfo.hemogoblin} Hgb", style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                      )
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red.shade700),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Trombosit", style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(height: 4),
                          Text("${userInfo.trombosit}", style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.white,
                  onTap: () {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ChangePasswordScreen();
                          })
                       );
                  },
                  leading: Icon(Icons.lock),
                  hoverColor: Color(0xFFF4F4F4),
                  title: Text("Ganti Password"),
                ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.white,
                  onTap: () {},
                  leading: Icon(Icons.help),
                  hoverColor: Color(0xFFF4F4F4),
                  title: Text("FAQ"),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.white,
                   onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          AuthUtility.clearUserInfo();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                        child: const Text("Yes")),
                  ],
                );
              });
        },
                  leading: Icon(Icons.logout),
                  hoverColor: Color(0xFFF4F4F4),
                  title: Text("Keluar"),
                ),
              ],
            )
          )
        )
      );
  }
}