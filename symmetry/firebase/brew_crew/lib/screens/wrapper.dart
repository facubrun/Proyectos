import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/theuser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser?>(context);
    print(user);

    // devolver home o authenticate widget
    if (user == null) { 
      return const Authenticate();
    } else {
       return Home();
    }   
  }
}