import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends GetxController {
  //Crea el futuro para iniciar sesion, deben recibirse como params el email y contraseña
  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Future.error('Wrong password provided for that user.');
      }
    }
  }

  //Crea el futuro para el registro de nuevos usuarios, deben recibirse como params el email y contraseña
  Future<void> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      }
    }
  }

  //Crea el futuro para cerrar sesion
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }
}
