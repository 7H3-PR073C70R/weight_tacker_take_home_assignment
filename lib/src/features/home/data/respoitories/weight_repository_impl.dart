import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/src/core/error/unexcepted_failure.dart';
import '../../domain/entities/weight.dart';
import '../../domain/repositories/weight_repository.dart';
import '../datasources/remote_datatsource.dart';

class WeightRepositoyImpl implements WeightRepository {
  RemoteDataSource remoteDataSource;
  WeightRepositoyImpl({required this.remoteDataSource});

  @override
  Future<void> addWeight(Weight weight) async {
    try {
      return await remoteDataSource.addWeight(weight);
    } catch (e) {
      throw UnexceptedFailure();
    }
  }

  @override
  Future<void> deleteWeight(String id) async {
    try {
      return await remoteDataSource.deleteWeight(id);
    } catch (e) {
      throw UnexceptedFailure();
    }
  }

  @override
  Future<void> editWeight(Weight weight) async {
    try {
      return await remoteDataSource.editWeight(weight);
    } catch (e) {
      throw UnexceptedFailure();
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getWeights() {
    try {
      return remoteDataSource.getWeights();
    } catch (e) {
      throw UnexceptedFailure();
    }
  }
}

final weightRepositoy = Provider((ref) {
  final remoteDataSource = ref.read(remoterDataSource);
  return WeightRepositoyImpl(remoteDataSource: remoteDataSource);
});
