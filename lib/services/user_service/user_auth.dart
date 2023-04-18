import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_time_planner/models/user/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserAuth {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  ///Registering with Email is done here in this function. Passing the required parameter will sign user up in the application.
  Future<void> registerWithEmailandPass({
    required String email,
    required String password,
    required String fullName,
    required String age,
    required String location,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullName': fullName,
      'age': age,
      'email': email,
      'passWord': password,
      'location': location,
      'avatar': '',
      'bio': 'tourist_attraction'
    });
  }

  ///Registering with Email is done here in this function. Passing the required parameter will sign user up in the application.
  Future<void> updateProfile({
    required String bio,
    required String fullName,
    required String budget,
    required String country,
    required String availableTo,
    required String availableFrom,
  }) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'fullName': fullName,
      'bio': bio,
      'budget': budget,
      'country': country,
      'availableFrom': availableFrom,
      'availableTo': availableTo
    });
  }

  /// User can login with Email and password by providing the email and pass word that have already been created.
  Future<UserCredential?> loginWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserModel> userData() async {
    final userinfo = await getUserData();

    final user = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      passWord: userinfo['passWord'],
      age: userinfo['age'],
      location: userinfo['location'],
    );
    return user;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// We can get user data through this function
  Future getUserData() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final userData = docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data();
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return userData;
  }

  Future getUserSearch() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('resent search');

    final querySnapshot = await docRef.get();

    final searchlist = querySnapshot.docs.map((e) => e.data()).toList();
    return searchlist;
    //print(docRef);
    /* final userData = docRef.listen((event) {
      event.docs.map((e) => docRef.toList());
    }); */
    //return docRef;
    /* final userData = docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data();
        return data;
      }, */

    //onError: (e) => print("Error getting search history: $e"),
    return userData;
  }
}
