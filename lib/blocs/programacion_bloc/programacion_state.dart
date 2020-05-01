import 'package:equatable/equatable.dart';

abstract class ProgramacionState extends Equatable {
  const ProgramacionState();

  @override
  List<Object> get props => [];
}

class Loading extends ProgramacionState {}

class Ready extends ProgramacionState {}