import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/theuser.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyDPcIvC-6gcLdSVl8uwz_LM18h51y3rVQg", // paste your api key here
      appId:
          "1:313409853111:android:badb9881913f5575695f32", //paste your app id here
      messagingSenderId: "313409853111", //paste your messagingSenderId here
      projectId: "brew-crew-25110", //paste your project id here
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      initialData: TheUser(),
      value: AuthService().user,
      child: const MaterialApp(
      home:  Wrapper()
      ),
    );
    
  }
}

