import 'dart:ui';

import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key,required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text(
          'Registrate en Brew Crew',
          style: TextStyle(color: Colors.white)
        ),
         actions: <Widget>[
          TextButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: const Icon(Icons.person, color: Colors.white,),
            label: const Text('Inicia sesion', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor:Colors.brown), 
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Ingresa un correo' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val!.length < 6 ? 'Ingresa una contraseña de largo mayor a 6' : null ,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPass(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Por favor ponga un correo valido';
                          loading = false;
                        });
                      } 
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text(
                    'Registrate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                 const SizedBox(height: 12.0),
                  Text(error,style : const TextStyle(color: Colors.red,fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}