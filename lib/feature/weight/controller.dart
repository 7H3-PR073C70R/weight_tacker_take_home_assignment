import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/feature/weight/model/weight.dart';
import 'package:weight_tracker/repositoy/weight_repository.dart';

class WeightProvider extends ChangeNotifier {
  final Ref ref;
  bool isBusy = false;
  WeightProvider(this.ref);

  void setState() {
    isBusy = !isBusy;
    notifyListeners();
  }

  get weightRepository => ref.read(weightRepositoryProvider);
  void addWeight(Weight weight) {
    try {
      setState();
      weightRepository.addWeight(weight);
      setState();
    } catch (e) {
      setState();
      rethrow;
    }
  }

  void editWeight(Weight weight) {
    try {
      setState();
      weightRepository.updateWeight(weight);
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

  Stream<QuerySnapshot<Object?>> get weightStream =>
      weightRepository.weightStream;
}

final weightProvider = ChangeNotifierProvider((ref) => WeightProvider(ref));
