import 'package:equatable/equatable.dart';

abstract class HistorialState extends Equatable {
  const HistorialState();

  @override
  List<Object> get props => [];
}

class Loading extends HistorialState {}

class Ready extends HistorialState {}
