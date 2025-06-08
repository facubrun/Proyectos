import 'dart:async';
import 'package:brew_crew/models/theuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //crear objeto usuario basado en FirebaseUser
  TheUser? _userFromFirebase(User? user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<TheUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebase(user));
  }

  //iniciar sesion anonimo
  Future singInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(error){
        //ignore: avoid_print
        print(error.toString());
        return null;
    }
  }

  //iniciar sesion con email & pass
  Future signInWithEmailAndPass(String email,String password) async{
    try{
      UserCredential result =await _auth.signInWithEmailAndPassword(email: email,password: password); //metodo de firebase
      User user = result.user!;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //registrar con email & password
  Future registerWithEmailAndPass(String email,String password) async{
    try{
      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email,password: password); //metodo de firebase
      User user = result.user!;

      //crear un nuevo doc para el usuario(uid)
      await DatabaseService(uid: user.uid).updateUserData('0','new member',100);
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //cerrar sesion
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
        print(e.toString());
        return null;
    }
  }
}