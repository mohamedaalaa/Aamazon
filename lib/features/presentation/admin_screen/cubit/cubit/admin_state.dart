part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class PhotoTaken extends AdminState {}

class AddProduct extends AdminState {}

class ProductAdded extends AdminState {}

class ProductError extends AdminState {}

class FetchingProducts extends AdminState {}

class GotProducts extends AdminState {}

class FilterList extends AdminState {}
