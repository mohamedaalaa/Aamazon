part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchUserProducts extends HomeState {}

class GothUserProducts extends HomeState {}

class Error extends HomeState {}

class SearchProduct extends HomeState {}

class SearchDone extends HomeState {}

class GetDofd extends HomeState {}

class GotDofd extends HomeState {}
