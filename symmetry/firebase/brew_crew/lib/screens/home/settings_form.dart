import 'package:brew_crew/models/theuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
       if(snapshot.hasData){

         UserData? userData = snapshot.data;
         return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Actualiza tus preferencias de café',
                style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Por favor ingresa un nombre' : null ,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar cucharadas')
                    );
                  }).toList(),
                  onChanged: (val) => setState(() {
                    _currentSugars = val;
                  }),
                   ),
                //slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() {
                    _currentStrength = val.round();
                  }),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                    }
                  }, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text('Actualizar', style: TextStyle(color: Colors.white),),
                  ),
            ],
          ), 
        );
      } else {
        return const Loading();
      }
    }
    );
  }
}