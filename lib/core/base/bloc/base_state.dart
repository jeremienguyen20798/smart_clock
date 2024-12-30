import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {}

class NoInternetState extends BaseState {}

class HasInternetState extends BaseState {}
