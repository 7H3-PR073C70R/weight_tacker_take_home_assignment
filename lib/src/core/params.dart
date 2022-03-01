import 'package:equatable/equatable.dart';
import '../features/home/domain/entities/weight.dart';

class Params extends Equatable {
  final Weight? weight;
  const Params({this.weight});

  @override
  List<Object?> get props => [weight];
}