part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class IsDetailed extends CartState {}

class AddOrRemoveFromCart extends CartState {}

class AddedOrRemovedFromCart extends CartState {}

class RateProduct extends CartState {}

class RateDone extends CartState {}

class DeleteCart extends CartState {}

class CartDeleted extends CartState {}
