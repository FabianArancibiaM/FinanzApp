import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future getUserFirebase() async {
  CollectionReference collection = db.collection('Usuarios');
  QuerySnapshot querySnapshot = await collection.get();
  return querySnapshot.docs.first;
}
