import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/src/app/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final _repository = UserViewModel(UserRepository());

  String? name;
  @override
  void initState() {
    super.initState();
    _repository.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      name = _repository.userModels.value.name!;
    });
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.white);

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 0, 91, 226),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color.fromARGB(255, 0, 91, 226),
                ),
                const SizedBox(width: 35),
                Text(
                  "$name's Profile",
                  style: const TextStyle(
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
              _repository.logout();
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
