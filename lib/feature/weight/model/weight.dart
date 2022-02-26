import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  final String id;
  final num userWeight;
  final Timestamp date;

  Weight({
    required this.id,
    required this.userWeight,
    required this.date,
  });

  factory Weight.fromJson(Map<String, dynamic> json) =>
      Weight(id: json['id'], userWeight: json['weight'], date: json['date']);

  Map<String, dynamic> toJson() => {'id': id, 'weight': userWeight, 'date': date};

  Weight copyWith({num? userWeight}) => Weight(
      id: id,
      userWeight: userWeight ?? this.userWeight,
      date: date );
}
