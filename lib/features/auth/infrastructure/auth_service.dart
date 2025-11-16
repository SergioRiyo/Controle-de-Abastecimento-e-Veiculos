import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

  }
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<void> register(String email, String password) async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

}