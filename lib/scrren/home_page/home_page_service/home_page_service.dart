import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePageService {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String endPoint;
  late DatabaseReference ref;
  late Stream stream;
  HomePageService() {
    endPoint = 'users';
    ref = FirebaseDatabase.instance.ref(endPoint);
    stream = FirebaseDatabase.instance.ref(endPoint).once().asStream();
  }

  Future<DatabaseEvent> get() async {
    DatabaseEvent event = await ref.child(auth.currentUser!.uid).once();
    print(event.snapshot.value);
    return event;
  }

  Future<Stream> getStream() async {
    Stream event = stream;
    print(event);
    return event;
  }

  Future<void> logoutUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
