import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/weight.dart';
import '../model/weight_model.dart';

abstract class RemoteDataSource {
  Stream<QuerySnapshot<Object?>> getWeights();
  Future<void> addWeight(Weight weight);
  Future<void> deleteWeight(String id);
  Future<void> editWeight(Weight weight);
}

class RemoterDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  const RemoterDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});

  String get _userId => firebaseAuth.currentUser?.uid ?? 'jhkhkhkskkjkjsk';
  CollectionReference get _collectionPath => firebaseFirestore
      .collection('Weights Tracker')
      .doc(_userId)
      .collection('Added Weights');

  @override
  Future<void> addWeight(Weight weight) async {
    _collectionPath
        .add(WeightModel(
                id: weight.id, userWeight: weight.userWeight, date: weight.date)
            .toJson())
        .then((value) async =>
            await _collectionPath.doc(value.id).update({'id': value.id}));
  }

  @override
  Future<void> deleteWeight(String id) async {
    _collectionPath.doc(id).delete();
  }

  @override
  Future<void> editWeight(Weight weight) async {
    _collectionPath.doc(weight.id).update(WeightModel(
            id: weight.id, userWeight: weight.userWeight, date: weight.date)
        .toJson());
  }

  @override
  Stream<QuerySnapshot<Object?>> getWeights() {
    return _collectionPath.orderBy('date', descending: true).snapshots();
  }
}

final remoterDataSource = Provider((ref) {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  return RemoterDataSourceImpl(
      firebaseFirestore: firebaseFirestore, firebaseAuth: firebaseAuth);
});
