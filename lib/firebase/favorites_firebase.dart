import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FavoritesFirebase {
  FirebaseFirestore _firebase = FirebaseFirestore.instance;

  CollectionReference? _favoritosCollection;

  FavoritesFirebase() {
    _favoritosCollection = _firebase.collection("favoritos");
  }

  insFavorite(Map<String, dynamic> map) async {
    return _favoritosCollection!.doc().set(map);
  }

  Future<void> updFavorite(Map<String, dynamic> map, String id) async {
    return _favoritosCollection!.doc(id).set(map);
  }

  Future<void> delFavorite(String id) async {
    return _favoritosCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    return _favoritosCollection!.snapshots();
  }
}
