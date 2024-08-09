import 'package:equatable/equatable.dart';

// Events
abstract class HomeScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTokenEvent extends HomeScreenEvent {}