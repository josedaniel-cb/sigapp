import 'package:equatable/equatable.dart';

abstract class InformeState extends Equatable {
  const InformeState();

  @override
  List<Object> get props => [];
}

class Loading extends InformeState {}

class Ready extends InformeState {}