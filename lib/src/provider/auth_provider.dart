import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_brain/src/models/user_model.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel userModel = UserModel.fromJson({});

  bool get isAuthenticated => userModel.email.isNotEmpty;

  UserModel get user => userModel;
}
