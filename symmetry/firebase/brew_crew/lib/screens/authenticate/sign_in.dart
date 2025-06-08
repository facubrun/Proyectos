import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key,required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String error = '';
  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0.0,
        title: const Text(
          'Inicia sesion en Brew Crew',
          style: TextStyle(color: Colors.white)
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: const Icon(Icons.person, color: Colors.white,),
            label: const Text('Registrate aqui', style: TextStyle(color: Colors.white)),
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
                  validator: (val) => val!.length < 6 ? 'Ingresa una contraseña de largo mayor a 6' : null,
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
                      dynamic result = await _auth.signInWithEmailAndPass(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'No se puede ingresar con estas credenciales';
                          loading = false;
                        });
                      }
                    }
                  },    
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text(
                    'Iniciar sesion',
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