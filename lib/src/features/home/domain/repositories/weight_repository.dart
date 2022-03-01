import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/weight.dart';

abstract class WeightRepository {
  Stream<QuerySnapshot<Object?>> getWeights();
  Future<void> addWeight(Weight weight);
  Future<void> deleteWeight(String id);
  Future<void>editWeight(Weight weight);
}
