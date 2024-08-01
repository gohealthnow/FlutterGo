import 'package:flutter/material.dart';
import 'package:gohealth/src/app/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.white);

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 0, 91, 226),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Color.fromARGB(255, 0, 91, 226),
                ),
                SizedBox(width: 35),
                Text(
                  "Gabriel's Profile",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 0, 91, 226),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home', style: textStyle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Profile', style: textStyle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings', style: textStyle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Logout', style: textStyle),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const SplashPage()));
            },
          ),
        ],
      ),
    );
  }
}
