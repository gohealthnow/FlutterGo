import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/splash_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final _repository = SharedLocalStorageService();

  String? name;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await _repository.getProfile();
      setState(() {
        name = profile?.name?.split(" ")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle =
        TextStyle(color: Color.fromARGB(255, 0, 91, 226));

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 0, 91, 226)),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 35),
                Expanded(
                  child: Text(
                    "Perfil de $name",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Adiciona reticências se o texto for muito longo
                  ),
                ),
                const FlutterLogo(),
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
              UserRepository prefs = UserViewModel(UserRepository()).repository;

              await prefs.logout();
              _repository.clearProfile();
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
