import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/src/features/home/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/src/features/login/data/repositories/login_repository_impl.dart';
import '../../data/respoitories/weight_repository_impl.dart';
import '../../domain/entities/weight.dart';

class WeightProvider extends ChangeNotifier {
  final Ref ref;
  bool isBusy = false;
  WeightProvider(this.ref);

  void setState() {
    isBusy = !isBusy;
    notifyListeners();
  }

  WeightRepository get weightRepository => ref.read(weightRepositoy);
  Future<void> addWeight(Weight weight) async {
    try {
      setState();
      await weightRepository.addWeight(weight);
      setState();
    } catch (e) {
      setState();
      rethrow;
    }
  }

  Future<void> editWeight(Weight weight) async {
    try {
      setState();
      await weightRepository.editWeight(weight);
      setState();
    } catch (e) {
      setState();

      rethrow;
    }
  }

  void deleteWeight(String id) {
    try {
      setState();
      weightRepository.deleteWeight(id);
      setState();
    } catch (e) {
      setState();

      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      setState();
      await ref.read(authRepository).logout();
      setState();
    } catch (e) {
      setState();

      rethrow;
    }
  }

  Stream<QuerySnapshot<Object?>> get weightStream =>
      weightRepository.getWeights();
}

final weightProvider = ChangeNotifierProvider((ref) => WeightProvider(ref));
