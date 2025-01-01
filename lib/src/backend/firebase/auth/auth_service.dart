import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      logger.d('SIGN IN WITH EMAIL AND PASSWORD :$e');
    }
    return null;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      logger.d('REGISTER WITH EMAIL AND PASSWORD :$e');
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      logger.d('SIGN OUT :$e');
    }
  }

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      logger.d('CURRENT USER :$e');
    }
    return null;
  }
}
