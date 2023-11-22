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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () => print('Teste5'),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: 200,
                  height: 200,
                  child: ElevatedButton.icon(
                    onPressed: () => print('Teste'),
                    icon: const Icon(Icons.add, color: Colors.black,),
                    label: const Text('Adiocione uma foto',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.black12),
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton.extended(
                  onPressed: () => print('teste22'),
                  label: const Text(
                    'Meu Perfil',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton.extended(
                  onPressed: () => print('teste33'),
                  label: const Text(
                    'Configurações',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton.extended(
                  onPressed: () => print('teste45'),
                  label: const Text(
                    'Em alta',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  icon: const Icon(
                    Icons.trending_up,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton.extended(
                  onPressed: () => print('teste66'),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),)
        ,
      )
      ,
    );
  }
}
//Text('Adiocione uma foto', style: TextStyle(color: Colors.black),)