import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/feature/weight/model/weight.dart';
import '../feature/auth/firebase_auth.dart';

class WeightRepository {
  final Ref ref;
  WeightRepository(this.ref);
  final _firebaseAuth = FirebaseFirestore.instance;
  String get _userId => ref.read(authenticationService).userID ?? 'jhkhkhkskkjkjsk';
  CollectionReference get _collectionPath => _firebaseAuth
      .collection('Weights Tracker')
      .doc(_userId)
      .collection('Added Weights');

  Stream<QuerySnapshot<Object?>> get weightStream => _collectionPath.orderBy('date', descending: true).snapshots();

  Future<void> addWeight(Weight weight) async {
    try {
      _collectionPath.add(weight.toJson()).then((value) async =>
          await _collectionPath.doc(value.id).update({'id': value.id}));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWeight(String id) async {
    try {
      _collectionPath.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWeight(Weight weight) async {
    try {
      _collectionPath.doc(weight.id).update(weight.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  return WeightRepository(ref);
});
