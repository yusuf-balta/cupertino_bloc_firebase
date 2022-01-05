import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginPageService {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String endPoint;
  late DatabaseReference ref;
  LoginPageService() {
    endPoint = 'users';
    ref = FirebaseDatabase.instance.ref(endPoint);
  }

  Future<bool> create(Map map, String uuid) async {
    try {
      await ref.child(uuid).set(map);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> createUser(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>>${e.code}");
      return e.code;
    }
  }
}
