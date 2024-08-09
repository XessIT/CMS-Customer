import 'package:equatable/equatable.dart';

abstract class HomeScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class TokenLoaded extends HomeScreenState {
  final String token;

  TokenLoaded(this.token);

  @override
  List<Object> get props => [token];
}

class TokenLoadFailure extends HomeScreenState {}