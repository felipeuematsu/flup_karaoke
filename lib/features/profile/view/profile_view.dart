import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flup_karaoke/helper/fish_assets.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const fish = FishAssets.sad;
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 200,
                
                child: ClipRRect(borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(color: Colors.black12,
                          child: const Icon(Icons.add,color: Colors.black,size: 32,))),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text(
                  'Meu Perfil',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                onTap: () {},
                leading: const Icon(
                  Icons.person,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text(
                  'Configurações',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                onTap: () {},
                leading: const Icon(
                  Icons.settings,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                onTap: () {},
                leading: const Icon(
                  Icons.logout,
                  size: 28,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
