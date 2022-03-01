import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/weight.dart';

class WeightModel extends Weight {
  const WeightModel(
      {required String id, required num userWeight, required Timestamp date})
      : super(id: id, userWeight: userWeight, date: date);

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
      id: json['id'], userWeight: json['weight'], date: json['date']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'weight': userWeight, 'date': date};
}
