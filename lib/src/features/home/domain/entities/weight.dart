import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Weight extends Equatable{
  final String id;
  final num userWeight;
  final Timestamp date;

  const Weight({
    required this.id,
    required this.userWeight,
    required this.date,
  });

  Weight copyWith({num? userWeight}) => Weight(
      id: id,
      userWeight: userWeight ?? this.userWeight,
      date: date );

  @override
  List<Object?> get props => [id, userWeight, date];
}
