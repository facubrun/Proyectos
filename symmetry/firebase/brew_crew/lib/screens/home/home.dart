import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 60.0),
          child: const SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text('Brew Crew',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.brown[500],
          elevation:0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: ()async{
                await _auth.signOut();
              }, 
              icon: const Icon(Icons.person, color: Colors.white,), 
              label: const Text('Cerrar sesion', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(const Color.fromARGB(255, 83, 39, 23)))
            ),
            TextButton.icon(
              onPressed: (){
                _showSettingsPanel();
            }
            , icon: const Icon(Icons.settings, color: Colors.white,),
            label: const Text('Ajustes', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('/assets/coffe_bg.png'),
              fit: BoxFit.cover,
              ),
            ),
          child: const BrewList()
          ),
      ),
    );
  }
}